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

class MonthCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var monthDataSource: MonthCollectionViewDataSource?
//    let dayCollectionViewController = DayCollectionViewController()
    var blurEffectView = UIVisualEffectView()
    var currentlyViewedMemorable: Memorable?

    
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
        
        let dayNavigationItem = UIBarButtonItem(title: "Days", style: .Plain, target: self, action: #selector(self.segueToDayControllerViaNavBar(_:)))
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.displaySearchController(_:)))
        self.navigationItem.setRightBarButtonItems([ dayNavigationItem, searchNavigationItem ], animated: false)
        
        if currentlyViewedMemorable != nil {
            print("ON SEGUE Section", self.indexPathFromMemorable(self.currentlyViewedMemorable!).section, "Row:", self.indexPathFromMemorable(self.currentlyViewedMemorable!).row)
            self.collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(currentlyViewedMemorable!), atScrollPosition: .CenteredVertically, animated: false)
        }
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height - 46, self.view.frame.size.width, 46))
        let toolBarItem = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: nil)
        toolBar.setItems([toolBarItem], animated: false)
        toolBar.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.view.addSubview(toolBar)
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
    
    func segueToDayControllerViaNavBar(sender: UIBarButtonItem!) {
        //dayCollectionViewController.currentlyViewedMemorable =
        performSegueWithIdentifier("MonthNavToDayController", sender: sender)
        print("segueToDayController")
    }

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
                for indexPath in sortedIndexPaths {
                    print("Section:", indexPath.section, "Row:", indexPath.row)
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
                dayCollectionViewController.currentlyViewedMemorable = self.monthDataSource?.itemAtIndexPath(NSIndexPath(forRow: row, inSection: section))
            }
        }
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO what behavior do we want this to implement?
        print(indexPath.section, indexPath.row)
        let memorableToSend = monthDataSource?.memorablesByMonth[indexPath.section][indexPath.row]
        performSegueWithIdentifier("MonthCellToDayController", sender: memorableToSend as? AnyObject)
    }

    // MARK: - FlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = UIScreen.mainScreen().bounds.width / 5
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.mainScreen().bounds.width, height: 35)
    }
    
    private func indexPathFromMemorable(memorable: Memorable) -> NSIndexPath {
        for section in 0 ..< self.monthDataSource!.memorablesByMonth.count {
            if let row = self.monthDataSource?.memorablesByMonth[section].indexOf({ $0.uniqueId == memorable.uniqueId }) {
                return NSIndexPath(forRow: row, inSection: section)
            }
        }
        return NSIndexPath(forRow: 0, inSection: 0)
    }
}
