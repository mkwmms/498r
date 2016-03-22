//
//  FBMemorable.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableFacebookPhoto: Memorable, CustomDebugStringConvertible {

    var uniqueId: String

    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?

    var adapter: Adapter
    var metadata: Any
    var displayableData: Any?

    init(uniqueId: String, adapter: Adapter, metadata: [MemorableFacebookMetadata], creationDate: NSDate) {
        self.uniqueId = uniqueId
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
    }

    init(uniqueId: String, adapter: Adapter, metadata: [MemorableFacebookMetadata], creationDate: NSDate, tags: [String], isFavorite: Bool) {
        self.uniqueId = uniqueId
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
        self.tags = tags
        self.isFavorite = isFavorite
    }
 
    var debugDescription: String {
        return String(format: "MemorableFacebookItem<uniqueId: \(uniqueId), creationDate: \(creationDate), tags: \(tags), isFavorite \(isFavorite) %p>", arguments: [unsafeAddressOf(self)])
    }
}
