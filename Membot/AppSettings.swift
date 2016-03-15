//
//  Setting.swift
//  Membot
//
//  Created by Alex Andrews on 3/11/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class MemorableSourceSetting {
    
    var displayableName: String
    var isEnabled: Bool
    
    init(displayableName: String, isEnabled: Bool) {
        self.displayableName = displayableName
        self.isEnabled = isEnabled
    }
}

class AppSettings {
    
    private let facebookSetting = MemorableSourceSetting(displayableName: "Facebook", isEnabled: false)
    private let photosSetting = MemorableSourceSetting(displayableName: "Photos", isEnabled: false)
    private let calendarEventsSetting = MemorableSourceSetting(displayableName: "Calendar Events", isEnabled: false)
    
    var settings: [MemorableSourceSetting]

    init() {
        settings = [facebookSetting, photosSetting, calendarEventsSetting]
    }
}

