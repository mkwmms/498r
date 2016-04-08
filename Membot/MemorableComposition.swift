//
//  MemorableComposition.swift
//  Membot
//
//  Created by William Myers on 4/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import UIKit

class MemorableComposition: Memorable, CustomDebugStringConvertible {
    
    var uniqueId: String
    
    var adapter: Adapter
    var metadata: Any
    var displayableData: Any?
    
    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?
    
    init(uniqueId: String, adapter: Adapter, metadata: String, creationDate: NSDate) {
        self.uniqueId = uniqueId
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
    }
    
    init(uniqueId: String, adapter: Adapter, metadata: String, creationDate: NSDate, tags: [String], isFavorite: Bool) {
        self.uniqueId = uniqueId
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
        self.tags = tags
        self.isFavorite = isFavorite
    }
    
    var debugDescription: String {
        return "\nMemorableComposition<uniqueId: \(uniqueId), creationDate: \(creationDate)>"
    }
}