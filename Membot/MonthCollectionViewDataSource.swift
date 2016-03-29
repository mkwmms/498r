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
    private var currentCellPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    
    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return memorablesByMonth.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
                forIndexPath: indexPath) as! MonthHeaderCollectionReusableView

        guard memorablesByMonth.count > 0 && memorablesByMonth[indexPath.section].count > 0 else {
            headerView.monthHeaderDescription.text = "" // remove the place holder text
            return headerView
        }

        headerView.monthHeaderDescription.sizeToFit()
        headerView.monthHeaderDescription.text = memorablesByMonth[indexPath.section][0].creationDate.monthDescription()

        return headerView
    }

    func sortMemorablesByMonth() {

        guard MemorableMetadataCache.sharedInstance.allMemorables.count > 0 else {
            return
        }

        MemorableMetadataCache.sharedInstance.allMemorables.sortInPlace({
            $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
        })

        let calendar = NSCalendar.currentCalendar()
        var currentDate = MemorableMetadataCache.sharedInstance.allMemorables[0].creationDate
        var memorablesInCurrentMonth = [Memorable]()
        // Build up 2D array memorablesByMonth
        for mem in MemorableMetadataCache.sharedInstance.allMemorables {
            guard AppSettings.sharedInstance.memTypeIsOn(mem) && !(mem is MemorableCalendarEvent) else {
                continue
            }
            if !(calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Month)) {
                currentDate = mem.creationDate
                memorablesByMonth.append(memorablesInCurrentMonth)
                memorablesInCurrentMonth = [Memorable]()
            }
            memorablesInCurrentMonth.append(mem)
        }
        memorablesByMonth.append(memorablesInCurrentMonth)
    }

    private func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        return memorablesByMonth[indexPath.section][indexPath.row]
    }
}