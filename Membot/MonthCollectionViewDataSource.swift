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
    private var itemIdentifier: String?
    private var configureCellBlock: CollectionViewCellConfigureBlock

    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print("total count: ", memorablesByMonth.count)
        return memorablesByMonth.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("section: ", section, " ", memorablesByMonth[section].count)
        return memorablesByMonth[section].count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as UICollectionViewCell

        let memorable: Memorable = self.itemAtIndexPath(indexPath)
        self.configureCellBlock(cell: cell, memorable: memorable)

        cell.backgroundColor = UIColor.redColor()
        return cell
    }

    // FIXME does not sort correctly...
    func sortMemorablesByMonth() {
        guard MemorableMetadata.sharedInstance.allMemorables.count > 0 else {
            return
        }

        let calendar = NSCalendar.currentCalendar()
        var currentDate = MemorableMetadata.sharedInstance.allMemorables[0].creationDate
        var memorablesInCurrentMonth = [Memorable]()
        // Build up 2D array memorablesByMonth
        for mem in MemorableMetadata.sharedInstance.allMemorables {
            if calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Month) {
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
