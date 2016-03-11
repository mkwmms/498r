//
//  Memorable.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

extension NSDate {

    func monthDescription() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM y"
        return formatter.stringFromDate(self)
                
//        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.components([.Month, .Year], fromDate: self)
//        return "\(components.month) \(components.year)"
    }
    
    func dayDescription() -> String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: .MediumStyle, timeStyle: .NoStyle)
    }

//    func stringToNSDate(dateString: String) -> NSDate {

//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        return dateFormatter.dateFromString(dateString)!
//    }
}

protocol Memorable {

    var adapter: Adapter { get set }
    var metadata: Any { get set }
    var displayableData: Any? { get set }

    var creationDate: NSDate { get set }
    var tags: [String]? { get set }
    var isFavorite: Bool? { get set }

    func refreshData()
}