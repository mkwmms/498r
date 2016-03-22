//
//  MonthCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MonthCollectionCellIdentifier"

class MonthCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var monthDataSource: MonthCollectionViewDataSource?

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(MonthCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        print("COUNT IN MONTH:", MemorableMetadataCache.sharedInstance.allMemorables.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "MonthCellToDayController") {
            let dayCollectionViewController = segue.destinationViewController as! DayCollectionViewController
            dayCollectionViewController.memorableFromSegue = sender as? Memorable
        }
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO what behavior do we want this to implement?
        print("Section:", indexPath.section, "Row:", indexPath.row)
        let memorableToSend = monthDataSource?.memorablesByMonth[indexPath.section][indexPath.row]
        performSegueWithIdentifier("MonthCellToDayController", sender: memorableToSend as? AnyObject)
    }
    
    // MARK: - FlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = UIScreen.mainScreen().bounds.width / 5
        return CGSize(width: cellSize, height: cellSize)
    }
}
