//
//  MemorableCalendarEvent.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class MemorableCalendarEvent: Memorable, CustomDebugStringConvertible {

    var adapter: Adapter
    var metadata: Any
    var displayableData: Any?

    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?

    init(adapter: Adapter, metadata: EKEvent, creationDate: NSDate) {
        self.metadata = metadata
        self.adapter = adapter
        self.creationDate = creationDate
    }

    init(adapter: Adapter, metadata: EKEvent, creationDate: NSDate, tags: [String], isFavorite: Bool) {
        self.adapter = adapter
        self.metadata = metadata
        self.creationDate = creationDate
        self.tags = tags
        self.isFavorite = isFavorite
    }
    
    func refreshData() -> Void {
        // TODO
//        event = self.data as! EKEvent
//        event.refresh()
//        creationDate = event.startDate
    }

    var debugDescription: String {
        return String(format: "MemorableCalendarEvent<creationDate: \(creationDate), tags: \(tags), isFavorite \(isFavorite) %p>", arguments: [unsafeAddressOf(self)])
    }
}