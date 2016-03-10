//
//  CalendarLibraryAdapter.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import EventKit

class CalendarLibraryAdapter: Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> ()) {
        let eventStore = EKEventStore()
        eventStore.requestAccessToEntityType(.Event, completion: { [eventStore]
            granted, error in
            guard error == nil else {
                print("ERROR: do not have access to calendar.")
                return
            }

            let startDate = NSDate(timeIntervalSinceNow: -(60 * 60 * 24 * 7 * 52 * 3)) // 3 years into past
            let predicate = eventStore.predicateForEventsWithStartDate(startDate, endDate: NSDate(), calendars: nil)
            let events = eventStore.eventsMatchingPredicate(predicate)
            // let events = NSMutableArray(array: eventStore.eventsMatchingPredicate(predicate))

            // TODO is it possible to not have to loop through this array?
            var memorableEvents = [Memorable]()
            for event in events {
                memorableEvents.append(MemorableCalendarEvent(adapter: self, metadata: event, creationDate: event.creationDate!))
            }
            completion(memorableEvents)
        })
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> ()) {
        // TODO
    }
}