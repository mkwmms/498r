//
//  MemorableFacebookMetadata.swift
//  Membot
//
//  Created by William Myers on 3/16/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableFacebookMetadata: CustomDebugStringConvertible {
    
    var source: NSURL
    var size: CGSize

    init(source: NSURL, size: CGSize) {
        self.source = source
        self.size = size
    }

    var debugDescription: String {
//        return String(format: "MemorableFacebookMetadata<source: \(source), size: \(size) %p>", arguments: [unsafeAddressOf(self)])
        return "\nMemorableFacebookMetadata<source: \(source), size: \(size)"
    }
}