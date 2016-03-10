//
//  MemorableMetadata.swift
//  Membot
//
//  Created by William Myers on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableMetadataCache {

    var allMemorables: [Memorable] // TODO should this be private?

    static let sharedInstance = MemorableMetadataCache()

    private init() {
        allMemorables = []
    }

    func retrieveMetadataFrom(adapter: Adapter) {
        // FIXME do not do this every time we add memorables?
        // memorables.sortInPlace({
        // $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
        // })

        adapter.retrieveMetadata { (memorables) -> () in
            self.allMemorables += memorables
        }
    }
}