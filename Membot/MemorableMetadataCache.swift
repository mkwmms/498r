//
//  MemorableMetadata.swift
//  Membot
//
//  Created by William Myers on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

class MemorableMetadataCache {
    
    // TODO use Haneke here?
    
    var allMemorables: [Memorable] // TODO should this be private?
    
    static let sharedInstance = MemorableMetadataCache()
    
    private init() {
        allMemorables = []
    }
    
    func retrieveMetadataFrom(adapter: Adapter) {
        adapter.retrieveMetadata { (memorables) -> Void in
            let newMemorables = self.union(self.allMemorables, with: memorables)
            if newMemorables.count > 0 {
                self.allMemorables += newMemorables
            }
        }
    }
    
    func sortInPlace() {
        allMemorables.sortInPlace({
            $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending
        })
    }
    
    // TODO make this a generic extension to array and make memorable conform to equatable
    // or at least use the map or filter function
    private func union(existing: [Memorable], with: [Memorable]) -> [Memorable] {
        var union = [Memorable]()
        for mem in with {
            if !existing.contains({ $0.uniqueId == mem.uniqueId })
                && !union.contains({ $0.uniqueId == mem.uniqueId }) {
                union.append(mem)
            }
        }
        return union
    }
}