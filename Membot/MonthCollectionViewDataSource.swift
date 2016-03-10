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
//        self.memorablesByMonth = memorablesByMonth
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.memorablesByMonth.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memorablesByMonth[section].count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as UICollectionViewCell

        let memorable: Memorable = self.itemAtIndexPath(indexPath)
//        if (self.configureCellBlock != nil) {
        self.configureCellBlock(cell: cell, memorable: memorable)
//        }

        return cell
    }

    func addMetaDataFrom(collectionView: UICollectionView, adapter: Adapter) {
        adapter.retrieveMetaData { (memorables) -> () in
            // FIXME do not do this every time we add memorables?
//            memorables.sortInPlace({
//                $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
//            })
            guard memorables.count > 0 else {
                return
            }

            let calendar = NSCalendar.currentCalendar()
            var currentDate = memorables[0].creationDate
            var memorablesInCurrentMonth = [Memorable]()
            // Build up 2D array memorablesByMonth
            for mem in memorables {
                if calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Month) {
                    memorablesInCurrentMonth.append(mem)
                } else {
                    currentDate = mem.creationDate
                    if memorablesInCurrentMonth.count > 0 {
                        self.memorablesByMonth.append(memorablesInCurrentMonth)
                        memorablesInCurrentMonth = [Memorable]()
                    }
                }
            }
            debugPrint(self.memorablesByMonth)
        }
    }

    private func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        return self.memorablesByMonth[indexPath.section][indexPath.row]
    }

}
