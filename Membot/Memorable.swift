//
//  Memorable.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

// TODO split this up into 2+ protocols? eg. DisplayableMemorable...

protocol Memorable {
    
    var uniqueId: String { get set }
    
    var adapter: Adapter { get set }
    var metadata: Any { get set }
    var displayableData: Any? { get set }
    
    var creationDate: NSDate { get set }
    var tags: [String]? { get set }
    var isFavorite: Bool? { get set }
}

extension NSDate {
    
    func monthDescription() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM y"
        return formatter.stringFromDate(self)
    }
    
    func dayDescription() -> String {
        return NSDateFormatter.localizedStringFromDate(self, dateStyle: .MediumStyle, timeStyle: .NoStyle)
    }
}

extension Memorable {
    
    func doesMatch(forQuery: String) -> Bool {
        return self.creationDate.monthDescription().lowercaseString.containsString(forQuery)
            || self.creationDate.dayDescription().lowercaseString.containsString(forQuery)
    }
}