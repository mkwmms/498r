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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(memorablesByDay.count)
        return memorablesByDay.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(memorablesByDay[section].count)
        return memorablesByDay[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier!, forIndexPath: indexPath) as! DayCollectionViewCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView =
        collectionView.dequeueReusableSupplementaryViewOfKind(kind,
            withReuseIdentifier: dayHeaderIdentifier,
            forIndexPath: indexPath) as! DayHeaderCollectionReusableView
        return headerView
    }
    
    func sortMemorablesByMonth() {
        
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
//            if calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Month) && !(mem is MemorableCalendarEvent) {
            if calendar.isDate(mem.creationDate, equalToDate: currentDate, toUnitGranularity: .Day) {
                memorablesInCurrentDay.append(mem)
            } else {
                currentDate = mem.creationDate
                if memorablesInCurrentDay.count > 0 {
                    memorablesByDay.append(memorablesInCurrentDay)
                    memorablesInCurrentDay = [Memorable]()
                }
            }
        }
    }
}
