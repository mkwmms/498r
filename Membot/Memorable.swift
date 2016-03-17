//
//  Memorable.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

// TODO split this up into 2+ protocols? eg. DisplayableMemorable...
// TODO make Memorable also conform to Equatable but there are compiler errors about having a Self type
//      but maybe they don't need to? see line 36ish of MemorableMetaDataCache
protocol Memorable {

    var uniqueId: String { get set }

    var adapter: Adapter { get set }
    var metadata: Any { get set }
    var displayableData: Any? { get set }

    var creationDate: NSDate { get set }
    var tags: [String]? { get set }
    var isFavorite: Bool? { get set }
}

// TODO default implementation...
//extension Memorable {
//    func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.uniqueId == rhs.uniqueId
//    }
//}

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