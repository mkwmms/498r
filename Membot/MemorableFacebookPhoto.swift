//
//  FBMemorable.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableFacebookPhoto: Memorable, CustomDebugStringConvertible {

    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?

    var adapter: Adapter
    var metadata: Any
    var displayableData: Any?

    init(adapter: Adapter, metadata: Any, creationDate: NSDate) {
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
    }

    init(adapter: Adapter, metadata: Any, creationDate: NSDate, tags: [String], isFavorite: Bool) {
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
        return String(format: "MemorableFacebookItem<creationDate: \(creationDate), tags: \(tags), isFavorite \(isFavorite) %p>", arguments: [unsafeAddressOf(self)])
    }
}
