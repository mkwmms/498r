//
//  SettingsTableViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CoreData

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingCellLabel: UILabel!
    @IBOutlet weak var settingCellSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Maybe in the future we'll show a description of each option when user taps row
        
        self.selectionStyle = .None
    }

    @IBAction func settingsCellSwitchChanged(sender: AnyObject) {
        
        retrieveMetaDataForOnSettings()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("Setting",
            inManagedObjectContext: managedContext)
        let request = NSFetchRequest()
        request.entity = entityDescription
        let predicate = NSPredicate(format: "(displayableName = %@)", settingCellLabel.text!)
        request.predicate = predicate
        do {
            let results = try managedContext.executeFetchRequest(request)
            let result = results[0] as! NSManagedObject
            let displayableName = result.valueForKey("displayableName")
            result.setValue(self.settingCellSwitch.on, forKey: "isOn")
            try managedContext.save()
            AppSettings.sharedInstance.updateSetting(displayableName as! String, isOn: self.settingCellSwitch.on)
            
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")

        }
    }
    
    func retrieveMetaDataForOnSettings() {
        if self.settingCellSwitch.on {
            switch self.settingCellLabel.text! {
            case "Facebook":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(FacebookPhotosAdapter())
            case "Photos":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(PhotoLibraryAdapter())
            case "Calendar Events":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(CalendarLibraryAdapter())
            default:
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(FacebookPhotosAdapter())
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(CalendarLibraryAdapter())
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(PhotoLibraryAdapter())
            }
        }
    }
}
