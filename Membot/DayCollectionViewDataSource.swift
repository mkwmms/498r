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
    var filteredMemorablesByDay = [[Memorable]]()
    
    private var dayHeaderIdentifier = "DayHeaderCollectionReusableView"
    
    private var cellIdentifier: String?
    private var configureCellBlock: CollectionViewCellConfigureBlock
    
    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        filteredMemorablesByDay = memorablesByDay
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByDay.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByDay[section].count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier!,
                                                                  forIndexPath: indexPath) as! DayCollectionViewCell
        
        if let memorable: Memorable = self.itemAtIndexPath(indexPath) {
            configureCellBlock(cell: cell, memorable: memorable)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                                                          atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                               withReuseIdentifier: dayHeaderIdentifier,
                                                                               forIndexPath: indexPath) as! DayHeaderCollectionReusableView
        
        // FIXME: The alpha cannot be set in the storyboard, the color cannot be changed here
        headerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        
        guard filteredMemorablesByDay.count > 0 && filteredMemorablesByDay[indexPath.section].count > 0 else {
            headerView.dayHeaderDescription.text = "" // remove the place holder text
            return headerView
        }
        
        headerView.dayHeaderDescription.sizeToFit()
        headerView.dayHeaderDescription.text =
            filteredMemorablesByDay[indexPath.section][0].creationDate.dayDescription()
        
        return headerView
    }
    
    func sortMemorablesByDay() {
        guard MemorableMetadataCache.sharedInstance.allMemorables.count > 0 else {
            return
        }
        
        MemorableMetadataCache.sharedInstance.sortInPlace()
        
        let calendar = NSCalendar.currentCalendar()
        var currentDate = MemorableMetadataCache.sharedInstance.allMemorables[0].creationDate
        var memorablesInCurrentDay = [Memorable]()
        // Build up 2D array memorablesByDay
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
        filteredMemorablesByDay = memorablesByDay
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByDay[indexPath.section][indexPath.row]
    }
}

// MARK: - Search

extension DayCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var query = searchController.searchBar.text
        
        if query == nil || query == "" {
            self.dayDataSource!.filteredMemorablesByDay = self.dayDataSource!.memorablesByDay
        } else {
            query = query?.lowercaseString
            
            let result = self.dayDataSource!.memorablesByDay.filter { (memorables: [Memorable]) -> Bool in
                return memorables.filter({ (mem) -> Bool in
                    return mem.doesMatch(query!)
                }).count > 0
            }
            self.dayDataSource!.filteredMemorablesByDay = result
        }
        self.collectionView!.reloadData()
    }
}