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

class MemorablePhoto: Memorable, CustomDebugStringConvertible {
    
    var adapter: Adapter
    var metadata: Any
    var displayableData: Any?
    
    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?

    init(adapter: Adapter, metadata: PHAsset, creationDate: NSDate) {
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
    }

    init(adapter: Adapter, metadata: PHAsset, creationDate: NSDate, tags: [String], isFavorite: Bool) {
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
        self.tags = tags
        self.isFavorite = isFavorite
    }

    func refreshData() {
        // TODO
    }

    var debugDescription: String {
        return String(format: "MemorablePhoto<creationDate: \(creationDate), tags: \(tags), isFavorite \(isFavorite) %p>", arguments: [unsafeAddressOf(self)])
    }
}