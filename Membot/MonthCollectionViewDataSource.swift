//
//  MonthCollectionViewDataSource.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

// TODO what the heck?
typealias CollectionViewCellConfigureBlock = (cell: UICollectionViewCell, memorable: Memorable) -> ()

class MonthCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var memorablesByMonth = [[Memorable]]()
    var filteredMemorablesByMonth = [[Memorable]]()
    
    private var monthHeaderIdentifier = "MonthHeaderCollectionReusableView"
    
    private var cellIdentifier: String?
    private var configureCellBlock: CollectionViewCellConfigureBlock
    private var currentCellPath: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    init(cellIdentifier: String, configureBlock: CollectionViewCellConfigureBlock) {
        filteredMemorablesByMonth = memorablesByMonth
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByMonth.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByMonth[section].count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier!,
                                                                         forIndexPath: indexPath) as! MonthCollectionViewCell
        
        if let memorable: Memorable = self.itemAtIndexPath(indexPath) {
            configureCellBlock(cell: cell, memorable: memorable)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            assert(false, "Unsupported supplementary view kind")
            return UICollectionReusableView()
        }
        
        let headerView =
            collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                  withReuseIdentifier: monthHeaderIdentifier,
                                                                  forIndexPath: indexPath) as! MonthHeaderCollectionReusableView
        
        // FIXME: The alpha cannot be set in the storyboard, the color cannot be changed here
        headerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        // headerView.backgroundColor?.colorWithAlphaComponent(0.30)
        
        guard filteredMemorablesByMonth.count > 0 && filteredMemorablesByMonth[indexPath.section].count > 0 else {
            headerView.monthHeaderDescription.text = "" // remove the place holder text
            return headerView
        }
        
        headerView.monthHeaderDescription.sizeToFit()
        headerView.monthHeaderDescription.text =
            filteredMemorablesByMonth[indexPath.section][0].creationDate.monthDescription()
        
        return headerView
    }
    
    func sortMemorablesByMonth() {
        guard MemorableMetadataCache.sharedInstance.allMemorables.count > 0 else {
            return
        }
        
        MemorableMetadataCache.sharedInstance.sortInPlace()
        
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
        filteredMemorablesByMonth = memorablesByMonth
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> Memorable {
        // Use filtered array in case we are searching. Both arrays are the same if we are not.
        return filteredMemorablesByMonth[indexPath.section][indexPath.row]
    }
}

// MARK: - Search

extension MonthCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var query = searchController.searchBar.text
        
        if query == nil || query == "" {
            self.monthDataSource!.filteredMemorablesByMonth = self.monthDataSource!.memorablesByMonth
        } else {
            query = query?.lowercaseString
            
            let result = self.monthDataSource!.memorablesByMonth.filter { (memorables: [Memorable]) -> Bool in
                return memorables.filter({ (mem) -> Bool in
                    return mem.doesMatch(query!)
                }).count > 0
            }
            self.monthDataSource!.filteredMemorablesByMonth = result
        }
        self.collectionView!.reloadData()
    }
}