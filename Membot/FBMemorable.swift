//
//  FBMemorable.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class FBMemorable: Memorable {

    init(creationDate: NSDate, data: Any) {
        self.creationDate = creationDate
        self.data = data
    }

    init(creationDate: NSDate, tags: [String], isFavorite: Bool, data: Any, displayableData: Any) {
        self.creationDate = creationDate
        self.tags = tags
        self.isFavorite = isFavorite
        self.data = data
        self.displayableData = displayableData
    }

    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?

    var data: Any
    var displayableData: Any?

    func refreshData() {
        // TODO
    }
}
