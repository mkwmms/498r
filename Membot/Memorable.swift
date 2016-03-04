//
//  Memorable.swift
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

protocol Memorable {

    var creationDate: NSDate { get set }
    var tags: [String]? { get set }
    var isFavorite: Bool? { get set }

    var data: Any { get set }
    var displayableData: Any? { get set }

    func refreshData()
}