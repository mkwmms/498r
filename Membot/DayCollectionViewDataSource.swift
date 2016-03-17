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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    }
}
