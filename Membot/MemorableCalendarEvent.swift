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
    var creationDate: NSDate
    var tags: [String]?
    var isFavorite: Bool?
    
//    var location: CLLocation?

    var data: Any
    var displayableData: Any?
    
    init(data: EKEvent) {
        self.data = data
        self.creationDate = data.startDate
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