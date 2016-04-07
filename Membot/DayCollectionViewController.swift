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

private let reuseIdentifier = "DayCollectionCellIdentifier"
private let dayHeaderIdentifier = "DayHeaderCollectionReusableView"

class DayCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let searchController = UISearchController(searchResultsController: SearchTableViewController())
    
    var dayDataSource: DayCollectionViewDataSource?
    var currentlyViewedMemorable: Memorable?
    var blurEffectView = UIVisualEffectView()
    var appToolBar = AppToolBar(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - 46, UIScreen.mainScreen().bounds.width, 46))

    override func viewDidLoad() {
        super.viewDidLoad()
//        pinchView.addGestureRecognizer(pinchRec)
//        pinchView.userInteractionEnabled = true

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
            
            collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(currentlyViewedMemorable!), atScrollPosition: .CenteredVertically, animated: false)
        }
        
        let monthsNavigationItem = UIBarButtonItem(title: "Months", style: .Plain, target: self, action: #selector(self.segueToMonthController(_:)))
        self.navigationItem.setLeftBarButtonItem(monthsNavigationItem, animated: false)
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.displaySearchController(_:)))
        let memorableNavigationItem = UIBarButtonItem(title: "Full", style: .Plain, target: self, action: #selector(self.segueToMemorableController(_:)))
        self.navigationItem.setRightBarButtonItems([ memorableNavigationItem, searchNavigationItem ], animated: false)
        
        self.appToolBar.currentViewController = self
        self.view.addSubview(appToolBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.appToolBar.frame = CGRectMake(0, UIScreen.mainScreen().bounds.width - 46, UIScreen.mainScreen().bounds.width, 46)
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
        performSegueWithIdentifier("DayNavToMonthController", sender: sender)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DayNavToMonthController" {
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
            print("Section:", section, "Row:", row)
            let monthCollectionViewController = segue.destinationViewController as! MonthCollectionViewController

            let indexPath = NSIndexPath(forRow: row, inSection: section)
            if let memorable = self.dayDataSource?.itemAtIndexPath(indexPath).metadata as? EKEvent {
                monthCollectionViewController.currentlyViewedMemorable = self.dayDataSource?.itemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
            }
            monthCollectionViewController.currentlyViewedMemorable = self.dayDataSource?.itemAtIndexPath(NSIndexPath(forRow: row, inSection: section))
        }
    }

//    func pinchedView(sender: UIPinchGestureRecognizer) {
//        self.view.bringSubviewToFront(pinchView)
//        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
//        sender.scale = 1.0
//    }

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
