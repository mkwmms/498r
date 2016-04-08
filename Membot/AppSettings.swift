//
//  Setting.swift
//  Membot
//
//  Created by Alex Andrews on 3/11/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation


/*
    If we ever figure out how to do programmatic viewcontrollers, we should not make this a singleton.
*/
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
    
    let facebookSetting = MemorableSourceSetting(displayableName: "Facebook", isOn: false)
    let photosSetting = MemorableSourceSetting(displayableName: "Photos", isOn: false)
    let calendarEventsSetting = MemorableSourceSetting(displayableName: "Calendar Events", isOn: false)
    let compositionSetting = MemorableSourceSetting(displayableName: "Journal Entries", isOn: false)
    
    var settings: [MemorableSourceSetting]
    
    init() {
        settings = [facebookSetting, photosSetting, calendarEventsSetting, compositionSetting]
    }
    
    func updateSetting(displayableName: String, isOn: Bool) {
        for appSetting in settings {
            if appSetting.displayableName == displayableName {
                appSetting.isOn = isOn
            }
        }
    }
    
    func memTypeIsOn(memorable: Memorable) -> Bool {
        if memorable is MemorableFacebookPhoto && facebookSetting.isOn || memorable is MemorablePhoto && photosSetting.isOn || memorable is MemorableCalendarEvent && calendarEventsSetting.isOn {
            return true
        } else {
            return false
        }
        
    }
    
}

