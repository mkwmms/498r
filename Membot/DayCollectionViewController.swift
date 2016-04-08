//
//  DayCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import Photos
import EventKit
import CocoaLumberjackSwift

private let reuseIdentifier = "DayCollectionCellIdentifier"
private let dayHeaderIdentifier = "DayHeaderCollectionReusableView"

class DayCollectionViewController: UICollectionViewController {

    var dayDataSource: DayCollectionViewDataSource?
    var currentlyViewedMemorable: Memorable?

    var resultSearchController = UISearchController()
    var searchButton: UIBarButtonItem!

    // MARK: - Public Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        dayDataSource = DayCollectionViewDataSource(cellIdentifier: reuseIdentifier, configureBlock: { (cell, memorable) -> Void in
            if let actualCell = cell as? DayCollectionViewCell {
                if let mem = memorable as? Memorable {
                    actualCell.configureForItem(mem)
                }
            }
        })

        dayDataSource?.sortMemorablesByDay()

        collectionView!.dataSource = dayDataSource
        collectionView!.delegate = self

        if currentlyViewedMemorable != nil {
            collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(currentlyViewedMemorable!),
                atScrollPosition: .CenteredVertically, animated: false)
        }

        initSearchBar()

        initLeftBarButtonItems()
        initRightBarButtonItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard segue.identifier == "DayNavToMonthController" else {
            DDLogError("segue identifier != DayNavToMonthController")
            return
        }

        let indexPaths = self.collectionView!.indexPathsForVisibleItems()
        var section = 100
        var row = 500
        for indexPath in indexPaths {
            if indexPath.section <= section {
                section = indexPath.section
                if indexPath.row < row {
                    row = indexPath.row
                }
            }
        }

        DDLogVerbose("Section: " + section.description + "Row: " + row.description)
        let monthCollectionViewController = segue.destinationViewController as! MonthCollectionViewController

        let indexPath = NSIndexPath(forRow: row, inSection: section)
        if let memorable = self.dayDataSource?.itemAtIndexPath(indexPath).metadata as? EKEvent {
            monthCollectionViewController.currentlyViewedMemorable =
                self.dayDataSource?.itemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        }
        monthCollectionViewController.currentlyViewedMemorable =
            self.dayDataSource?.itemAtIndexPath(NSIndexPath(forRow: row, inSection: section))
    }

    // MARK: - Private

    func segueToMemorableController(sender: UIBarButtonItem!) {
        DDLogVerbose("segueToMemorableController")
    }

    func segueToMonthController(sender: UIBarButtonItem!) {
        performSegueWithIdentifier("DayNavToMonthController", sender: sender)
    }

    private func initLeftBarButtonItems() {
        self.navigationItem.setLeftBarButtonItems(createLeftBarButtonItems(), animated: false)
    }

    private func createLeftBarButtonItems() -> [UIBarButtonItem] {
        return [UIBarButtonItem(title: "Months", style: .Plain, target: self,
            action: #selector(self.segueToMonthController(_:)))
        ]
    }

    private func initRightBarButtonItems() {
        self.navigationItem.setRightBarButtonItems(createRightBarButtonItems(), animated: false)
    }

    private func createRightBarButtonItems() -> [UIBarButtonItem] {
        return [UIBarButtonItem(title: "Full", style: .Plain, target: self,
            action: #selector(self.segueToMemorableController(_:))), createSearchButton()
        ]
    }

    // FIXME code duplication
    private func indexPathFromMemorable(memorable: Memorable) -> NSIndexPath {
        for section in 0 ..< self.dayDataSource!.filteredMemorablesByDay.count {
            if let row = self.dayDataSource?.filteredMemorablesByDay[section]
                .indexOf({ $0.uniqueId == memorable.uniqueId }) {
                    return NSIndexPath(forRow: row, inSection: section)
            }
        }
        return NSIndexPath(forRow: 0, inSection: 0)
    }
}

// MARK: - FlowLayout

extension DayCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
            let memorable = dayDataSource?.filteredMemorablesByDay[indexPath.section][indexPath.row]
            if let memorableEvent = memorable as? MemorableCalendarEvent {
                return CGSize(width: UIScreen.mainScreen().bounds.width, height: 30)
            }
            let cellSize = UIScreen.mainScreen().bounds.width
            return CGSize(width: cellSize, height: cellSize)
    }
}

// MARK: - Search

extension DayCollectionViewController: UISearchBarDelegate {
    // TODO get rid of this code duplication

    func createSearchButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .Search, target: self,
            action: #selector(self.showSearchBar(_:)))
    }

    func initSearchBar() {
        self.resultSearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false // default true
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search by date"
            return controller
        }()

        self.resultSearchController.searchBar.delegate = self
    }

    func showSearchBar(sender: UIBarButtonItem!) {
        self.navigationItem.rightBarButtonItems = nil // FIXME I don't think this can just be hidden
        self.navigationItem.titleView = resultSearchController.searchBar
        resultSearchController.searchBar.becomeFirstResponder() // put cursor in query text box
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.navigationItem.titleView = nil
        initRightBarButtonItems()
    }
}
