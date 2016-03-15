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
    var isOn: Bool
    
    init(displayableName: String, isOn: Bool) {
        self.displayableName = displayableName
        self.isOn = isOn
    }
}

class AppSettings {
    
    // AppSetting singleton to acces in AppDelegate
    static let sharedInstance = AppSettings()
    
    private let facebookSetting = MemorableSourceSetting(displayableName: "Facebook", isOn: false)
    private let photosSetting = MemorableSourceSetting(displayableName: "Photos", isOn: false)
    private let calendarEventsSetting = MemorableSourceSetting(displayableName: "Calendar Events", isOn: false)
    
    var settings: [MemorableSourceSetting]

    init() {
        settings = [facebookSetting, photosSetting, calendarEventsSetting]
    }
    
    func updateSetting(displayableName: String, isOn: Bool) {
        for appSetting in settings {
            if appSetting.displayableName == displayableName {
                appSetting.isOn = isOn
            }
        }
    }
}

