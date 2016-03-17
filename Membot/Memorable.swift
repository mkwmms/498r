//
//  Memorable.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

protocol Memorable {

    var adapter: Adapter { get set }
    var metadata: Any { get set }
    var displayableData: Any? { get set }

    var creationDate: NSDate { get set }
    var tags: [String]? { get set }
    var isFavorite: Bool? { get set }
}

//protocol MemorableMetadata {
//    var source: Any { get set }
//    var size: CGSize { get set } // TODO should this be CGSize or Any?
//}
//
//protocol MemorableDisplayable {
//    var data: Any { get set }
//    
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