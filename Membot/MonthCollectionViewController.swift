//
//  MonthCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

private let reuseIdentifier = "MonthCollectionCellIdentifier"

class MonthCollectionViewController: UICollectionViewController {

    var monthDataSource: MonthCollectionViewDataSource?
    var currentlyViewedMemorable: Memorable?

    var resultSearchController = UISearchController()
    var searchButton: UIBarButtonItem!

    // MARK: - Public Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        // Init our datasource and setup the closure to handle our cell
        monthDataSource = MonthCollectionViewDataSource(cellIdentifier: reuseIdentifier, configureBlock: { (cell, memorable) -> Void in
            if let actualCell = cell as? MonthCollectionViewCell {
                if let mem = memorable as? Memorable {
                    actualCell.configureForItem(mem)
                }
            }
        })

        monthDataSource?.sortMemorablesByMonth()

        collectionView!.dataSource = monthDataSource

        if currentlyViewedMemorable != nil {
            self.collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(currentlyViewedMemorable!), atScrollPosition: .CenteredVertically, animated: false)
        }

        initSearchBar()

        initRightBarButtonItems()

        self.view.addSubview(createToolBar())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO what behavior do we want this to implement?
        DDLogVerbose("Section: " + indexPath.section.description + "Row: " + indexPath.row.description)
        let memorableToSend = monthDataSource?.memorablesByMonth[indexPath.section][indexPath.row]
        performSegueWithIdentifier("MonthCellToDayController", sender: memorableToSend as? AnyObject)
    }

    // FIXME
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MonthCellToDayController") {
            let dayCollectionViewController = segue.destinationViewController as! DayCollectionViewController
            dayCollectionViewController.currentlyViewedMemorable = sender as? Memorable
        } else if let button = sender as? UIBarButtonItem {
            if self.navigationItem.rightBarButtonItems![0] == button {
                let indexPaths = self.collectionView!.indexPathsForVisibleItems()

                let sortedIndexPaths = indexPaths.sort {
                    $0.section < $1.section
                }

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

                let dayCollectionViewController = segue.destinationViewController as! DayCollectionViewController
                dayCollectionViewController.currentlyViewedMemorable =
                    self.monthDataSource?.itemAtIndexPath(NSIndexPath(forRow: row, inSection: section))
            }
        }
    }

    // MARK: - Private

    func segueToDayControllerViaNavBar(sender: UIBarButtonItem!) {
        performSegueWithIdentifier("MonthNavToDayController", sender: sender)
    }

    private func initRightBarButtonItems() {
        self.navigationItem.setRightBarButtonItems(createRightBarButtonItems(), animated: false)
    }

    private func createRightBarButtonItems() -> [UIBarButtonItem] {
        return [UIBarButtonItem(title: "Days", style: .Plain, target: self,
            action: #selector(self.segueToDayControllerViaNavBar(_:))), createSearchButton()
        ]
    }

    private func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height - 46, self.view.frame.size.width, 46))
        let toolBarItem = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: nil)
        toolBar.setItems([toolBarItem], animated: false)
        toolBar.backgroundColor = UIColor(white: 1, alpha: 0.9)
        return toolBar
    }

    // FIXME code duplication
    private func indexPathFromMemorable(memorable: Memorable) -> NSIndexPath {
        for section in 0 ..< self.monthDataSource!.filteredMemorablesByMonth.count {
            if let row = self.monthDataSource?.filteredMemorablesByMonth[section]
                .indexOf({ $0.uniqueId == memorable.uniqueId }) {
                    return NSIndexPath(forRow: row, inSection: section)
            }
        }
        return NSIndexPath(forRow: 0, inSection: 0)
    }
}

// MARK: - FlowLayout

extension MonthCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = UIScreen.mainScreen().bounds.width / 5
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.mainScreen().bounds.width, height: 35)
    }
}

// MARK: - Search

extension MonthCollectionViewController: UISearchBarDelegate {
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
