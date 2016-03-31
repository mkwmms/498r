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
        
        let dayNavigationItem = UIBarButtonItem(title: "Days", style: .Plain, target: self, action: #selector(self.segueToDayController(_:)))
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.displaySearchController(_:)))
        self.navigationItem.setRightBarButtonItems([ dayNavigationItem, searchNavigationItem ], animated: false)
        
        
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
    func segueToDayController(sender: UIBarButtonItem!) {
        //dayCollectionViewController.currentlyViewedMemorable =
        performSegueWithIdentifier("MonthCellToDayController", sender: self)
        print("segueToDayController")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MonthCellToDayController") {
            let dayCollectionViewController = segue.destinationViewController as! DayCollectionViewController
            dayCollectionViewController.currentlyViewedMemorable = sender as? Memorable
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
}
