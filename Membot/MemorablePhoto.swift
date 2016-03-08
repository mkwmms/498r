//
//  MemorablePhoto.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import UIKit
import Photos

class MemorablePhoto: Memorable {
    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?
//    var location: CLLocation?
    
    var data: Any
    var displayableData: Any?
    
    init(date: NSDate, data: PHAsset) {
        self.creationDate = date
        self.data = data
    }
    
    init(date: NSDate, data: PHAsset, displayableData: UIImage) {
        self.creationDate = date
        self.data = data
        self.displayableData = displayableData
    }
    
    init(date: NSDate, tags: [String], isFavorite: Bool, data: PHAsset, displayableData: UIImage) {
        self.creationDate = date
        self.tags = tags
        self.isFavorite = isFavorite
        self.data = data
        self.displayableData = displayableData
    }
    
    func refreshData() {
        // TODO
    }
}