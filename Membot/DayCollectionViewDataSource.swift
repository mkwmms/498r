//
//  DayCollectionViewDataSource.swift
//  Membot
//
//  Created by Alex Andrews on 3/15/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class DayCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var memorablesByDay = [[Memorable]]()
    private var cellIdentifier: String?
    private var dayHeaderIdentifier = "DayHeaderCollectionReusableView"
    private var configureCellBlock: CollectionViewCellConfigureBlock
    
    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return memorablesByDay.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memorablesByDay[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier!, forIndexPath: indexPath) as! DayCollectionViewCell

        if let memorable: Memorable = self.itemAtIndexPath(indexPath) {
            configureCellBlock(cell: cell, memorable: memorable)
        }
        cell.backgroundColor = UIColor.lightGrayColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView =
        collectionView.dequeueReusableSupplementaryViewOfKind(kind,
            withReuseIdentifier: dayHeaderIdentifier,
            forIndexPath: indexPath) as! DayHeaderCollectionReusableView
        
        headerView.dayHeaderDescription.sizeToFit()
        headerView.dayHeaderDescription.text = memorablesByDay[indexPath.section][0].creationDate.dayDescription()
        return headerView
    }
    
    func sortMemorablesByDay() {
        
        guard MemorableMetadataCache.sharedInstance.allMemorables.count > 0 else {
            return
        }
        
        // FIXME: noticably slow... should we have an isSorted member?
        MemorableMetadataCache.sharedInstance.allMemorables.sortInPlace({
            $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
        })
        
        let calendar = NSCalendar.currentCalendar()
        var currentDate = MemorableMetadataCache.sharedInstance.allMemorables[0].creationDate
        var memorablesInCurrentDay = [Memorable]()
        // Build up 2D array memorablesByMonth
        for mem in MemorableMetadataCache.sharedInstance.allMemorables {
            guard AppSettings.sharedInstance.memTypeIsOn(mem) else {
                continue
            }
            if !(calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Day)) {
                currentDate = mem.creationDate
                memorablesByDay.append(memorablesInCurrentDay)
                memorablesInCurrentDay = [Memorable]()
            }
            memorablesInCurrentDay.append(mem)
        }
        memorablesByDay.append(memorablesInCurrentDay)
    }
    
    private func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        return memorablesByDay[indexPath.section][indexPath.row]
    }
}
