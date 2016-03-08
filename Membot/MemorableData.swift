//
//  MemorableData.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import UIKit

class MemorableData {

    // private var allMemorables = [NSDate: [Memorable]]()
    private var allMemorables = [Memorable]()

//    private let calendar = NSCalendar.currentCalendar()

    static let sharedInstance = MemorableData()

    private init() { }

//    func addMemorable(memorable: Memorable) -> Void {
//        allMemorables.append(memorable)
//    }

//    func addMemorablesByDay(day: Int, month: Int, year: Int, memorable: Memorable) {
//        let components = NSDateComponents()
//        components.year = year
//        components.month = month
//        components.day = day
//
//        if var mems = allMemorables[components] {
//            mems.append(memorable)
//        }
//    }
//
//    func addMemorablesByDay(day: Int, month: Int, year: Int, memorables: [Memorable]) {
//        let components = NSDateComponents()
//        components.year = year
//        components.month = month
//        components.day = day
//
//        if var mems = allMemorables[components] {
//            mems += memorables
//        }
//    }

    func sortMemorables() -> [Memorable] {
        return allMemorables.sort({ $0.creationDate.compare($1.creationDate) == NSComparisonResult.OrderedAscending })
    }

    func getMemorablesByDay() -> [Memorable] {
        return allMemorables
    }

    func addDataFrom(adapter: Adapter) {
        adapter.retrieveMetaData { (memorables) -> () in
            self.allMemorables += memorables
            print(self.allMemorables)
        }
    }

//    func getMemorablesByMonth(month: Int, year: Int) -> [Memorable] {
//        let matchMonth = NSDateComponents()
//        matchMonth.year = year
//        matchMonth.month = month
//        return allMemorables.filter {
//            calendar.date($0.creationDate, matchesComponents: matchMonth)
//        }
//    }
}
