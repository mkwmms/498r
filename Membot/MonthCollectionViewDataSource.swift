//
//  MonthCollectionViewDataSource.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

// TODO what the heck?
typealias CollectionViewCellConfigureBlock = (cell: UICollectionViewCell, memorable: Memorable) -> ()

class MonthCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var memorablesByMonth = [[Memorable]]()
    private var cellIdentifier: String?
    private var monthHeaderIdentifier = "MonthHeaderCollectionReusableView"
    private var configureCellBlock: CollectionViewCellConfigureBlock

    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        print("total count:", memorablesByMonth.count)
        return memorablesByMonth.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("section:", section, memorablesByMonth[section].count)
        return memorablesByMonth[section].count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier!, forIndexPath: indexPath) as! MonthCollectionViewCell

        if let memorable: Memorable = self.itemAtIndexPath(indexPath) {
            configureCellBlock(cell: cell, memorable: memorable)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView =
        collectionView.dequeueReusableSupplementaryViewOfKind(kind,
            withReuseIdentifier: monthHeaderIdentifier,
            forIndexPath: indexPath)
            as! MonthHeaderCollectionReusableView
        
        headerView.monthHeaderDescription.text = memorablesByMonth[indexPath.section][0].creationDate.monthDescription()
        
        return headerView
    }

// FIXME does not sort correctly...
    func sortMemorablesByMonth() {
    
        guard MemorableMetadataCache.sharedInstance.allMemorables.count > 0 else {
            return
        }

//        debugPrint(MemorableMetadataCache.sharedInstance.allMemorables)
        let calendar = NSCalendar.currentCalendar()
        var currentDate = MemorableMetadataCache.sharedInstance.allMemorables[0].creationDate
        var memorablesInCurrentMonth = [Memorable]()
        // Build up 2D array memorablesByMonth
        for mem in MemorableMetadataCache.sharedInstance.allMemorables {
            if calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Month) && !(mem is MemorableCalendarEvent) {
                memorablesInCurrentMonth.append(mem)
            } else {
                currentDate = mem.creationDate
                if memorablesInCurrentMonth.count > 0 {
                    memorablesByMonth.append(memorablesInCurrentMonth)
                    memorablesInCurrentMonth = [Memorable]()
                }
            }
        }
//        debugPrint(self.memorablesByMonth)
    }

    private func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        return memorablesByMonth[indexPath.section][indexPath.row]
    }
}
