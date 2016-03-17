//
//  MemorableMetadata.swift
//  Membot
//
//  Created by William Myers on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableMetadataCache {

    // TODO use Haneke here?
    
    var allMemorables: [Memorable] // TODO should this be private?

    static let sharedInstance = MemorableMetadataCache()

    private init() {
        allMemorables = []
    }

    // TODO: remove duplicate items... or use a set or something...
    func retrieveMetadataFrom(adapter: Adapter) {
        // FIXME do not do this every time we add memorables?
        // memorables.sortInPlace({
        // $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
        // })

        adapter.retrieveMetadata { (memorables) -> Void in
            self.allMemorables += memorables
        }
    }
}