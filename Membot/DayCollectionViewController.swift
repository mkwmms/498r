//
//  DayCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "DayCollectionCellIdentifier"
private let dayHeaderIdentifier = "DayHeaderCollectionReusableView"

class DayCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let searchController = UISearchController(searchResultsController: SearchTableViewController())
    var dayDataSource: DayCollectionViewDataSource?
    var currentlyViewedMemorable: Memorable?
    var blurEffectView = UIVisualEffectView()
//    var monthCollectionViewController = MonthCollectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = UIColor.whiteColor()

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
            collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(currentlyViewedMemorable!), atScrollPosition: .Top, animated: false)
        }
        
        let monthsNavigationItem = UIBarButtonItem(title: "Months", style: .Plain, target: self, action: #selector(self.segueToMonthController(_:)))
        self.navigationItem.setLeftBarButtonItem(monthsNavigationItem, animated: false)
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.displaySearchController(_:)))
        let memorableNavigationItem = UIBarButtonItem(title: "Full", style: .Plain, target: self, action: #selector(self.segueToMemorableController(_:)))
        self.navigationItem.setRightBarButtonItems([ memorableNavigationItem, searchNavigationItem ], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displaySearchController(sender: UIBarButtonItem!) {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.collectionView!.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let searchTableViewController = SearchTableViewController()
        searchTableViewController.tableView.backgroundView = blurEffectView
        let searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchResultsController?.modalPresentationStyle = .OverCurrentContext
        searchController.view.addSubview(blurEffectView)
        
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    func segueToMemorableController(sender: UIBarButtonItem!) {
        print("segueToMemorableController")
    }
    
    func segueToMonthController(sender: UIBarButtonItem!) {
//        presentViewController(monthCollectionViewController, animated: true, completion: nil)
        print("segueToMonthController")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MonthCellToDayController" {
        }
    }

    // MARK: - FlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let memorable = dayDataSource?.memorablesByDay[indexPath.section][indexPath.row]
        if let memorableEvent = memorable as? MemorableCalendarEvent {
            return CGSize(width: UIScreen.mainScreen().bounds.width, height: 30)
        }
        let cellSize = UIScreen.mainScreen().bounds.width
        return CGSize(width: cellSize, height: cellSize)
    }

    private func indexPathFromMemorable(memorable: Memorable) -> NSIndexPath {
        for section in 0 ..< self.dayDataSource!.memorablesByDay.count {
            if let row = self.dayDataSource?.memorablesByDay[section].indexOf({ $0.uniqueId == memorable.uniqueId }) {
                return NSIndexPath(forRow: row, inSection: section)
            }
        }
        return NSIndexPath(forRow: 0, inSection: 0)
    }
}
