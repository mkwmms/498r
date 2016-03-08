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

    func retrieveMetaData(completion: ([Memorable]) -> ()) {
        let eventStore = EKEventStore()

        eventStore.requestAccessToEntityType(.Event, completion: { [eventStore]
            granted, error in
            if (error != nil) {
                print("EROR: do not have access to calendar.")
                return
            }

            // let endDate = NSDate(timeIntervalSinceNow: 604800 * 10); // This is 10 weeks in seconds
            let predicate = eventStore.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
            let events = eventStore.eventsMatchingPredicate(predicate)
            // let events = NSMutableArray(array: eventStore.eventsMatchingPredicate(predicate))

            // TODO is it possible to not have to loop through this array?
            var memorableEvents = [Memorable]()
            for event in events {
                memorableEvents.append(MemorableCalendarEvent(data: event))
            }
            completion(memorableEvents)
        })
    }
    
    func retrieveData(completion: ([Memorable]) -> ()) {
        // TODO
    }
}