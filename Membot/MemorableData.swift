//
//  MemorableData.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableData {

    var allMemorables = [String: [Memorable]]()
    var allMemorablesArray = [Memorable]()

    static let sharedInstance = MemorableData()

    private init() { }
    
}
