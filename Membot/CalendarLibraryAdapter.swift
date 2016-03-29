//
//  CalendarLibraryAdapter.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import EventKit
import CocoaLumberjackSwift

class CalendarLibraryAdapter: Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> Void) {
        let eventStore = EKEventStore()
        eventStore.requestAccessToEntityType(.Event, completion: { [eventStore] granted, error in
            guard error == nil else {
                DDLogError("\(error?.localizedFailureReason) \(error?.localizedDescription)")
                return
            }

            let startDate = NSDate(timeIntervalSinceNow: -(60 * 60 * 24 * 7 * 52 * 3)) // 3 years into past
            let predicate = eventStore.predicateForEventsWithStartDate(startDate, endDate: NSDate(), calendars: nil)
            var memorableEvents = [Memorable]()
            eventStore.enumerateEventsMatchingPredicate(predicate, usingBlock: { (event, unsafePointer) -> Void in
                // TODO: shouldn't need this additional duplicate check... but we do...
                if event.calendar.title != "US Holidays" && !memorableEvents.contains({ $0.uniqueId == event.eventIdentifier }) {
                    memorableEvents.append(MemorableCalendarEvent(uniqueId: event.eventIdentifier,
                        adapter: self, metadata: event, creationDate: event.startDate))
                }
            })
            DDLogVerbose(memorableEvents.description)
            completion(memorableEvents)
        })
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void) {
        let image = UIImage(named: "peaches")
        completion(image as UIImage!)
        // TODO
        // event = self.data as! EKEvent
        // event.refresh()
        // creationDate = event.startDate
    }
}