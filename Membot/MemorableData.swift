//
//  MemorableData.swift
//  Membot
//
//  Created by William Myers on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

extension NSDate {
    
    func toString() -> String {
        return NSDateFormatter.localizedStringFromDate(
            self,
            dateStyle: .MediumStyle,
            timeStyle: .NoStyle // Do not display the time
        )
    }
    
}

class MemorableData {

    var allMemorables = [String: [Memorable]]()

    static let sharedInstance = MemorableData()

    private init() { }
    
}
