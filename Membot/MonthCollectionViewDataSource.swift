//
//  MonthCollectionViewDataSource.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

// TODO what the heck?
typealias CollectionViewCellConfigureBlock = (cell: UICollectionViewCell, item: Memorable) -> ()

class MonthCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private var memorablesByMonth = [[Memorable]]()
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

        let item: Memorable = self.itemAtIndexPath(indexPath)
//        if (self.configureCellBlock != nil) {
        self.configureCellBlock(cell: cell, item: item)
//        }

        return cell

        // Old implementation from month controller:
        /*
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MonthCollectionViewCell

         // Configure the cell

         //        view.addSubview(loginButton)
         //        loginButton.center = view.center
         //        loginButton.delegate = self


         //         define an UIImage
         //         add it to the cell

         if MemorableData.sharedInstance.getMemorablesByDay().count == 0 {
         return cell
         }

         if let url = MemorableData.sharedInstance.getMemorablesByDay()[indexPath.row].data as? NSURL {
         let imageDataFromURL = NSData(contentsOfURL: url)


         let fbImage = UIImage(data: imageDataFromURL!)

         let imageView = UIImageView(image: fbImage)

         cell.addSubview(imageView)
         imageView.center = cell.center
         } else {

         }
         return cell
         */
    }

    func addMetaDataFrom(adapter: Adapter) {
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
        }
    }

    private func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        return self.memorablesByMonth[indexPath.section][indexPath.row]
    }

}
