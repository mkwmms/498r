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
    
    var dayDataSource: DayCollectionViewDataSource?
    var memorableFromSegue: Memorable?
    
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
        
        if memorableFromSegue != nil {
            collectionView?.scrollToItemAtIndexPath(indexPathFromMemorable(memorableFromSegue!), atScrollPosition: .Top, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MonthCellToDayController" {

        }
    }

    // MARK: - FlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = UIScreen.mainScreen().bounds.width
        return CGSize(width: cellSize, height: cellSize)
    }
    
    private func indexPathFromMemorable(memorable: Memorable) -> NSIndexPath {
        for var section = 0; section < self.dayDataSource!.memorablesByDay.count; section++ {
            if let row = self.dayDataSource?.memorablesByDay[section].indexOf({ $0.uniqueId == memorable.uniqueId }) {
                return NSIndexPath(forRow: row, inSection: section)
            }
        }
        return NSIndexPath(forRow: 0, inSection: 0)
    }
}
