//
//  SettingsTableViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CoreData
import CocoaLumberjackSwift

class SettingsTableViewCell: UITableViewCell {
    
    var settingCellLabel: UILabel!
    var settingCellSwitch: UISwitch!
    var currentViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.settingCellLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 50))
        self.settingCellSwitch = UISwitch(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 64, y: 5, width: 44, height: 44))
        self.settingCellSwitch.addTarget(self, action: #selector(self.settingsCellSwitchChanged(_:)), forControlEvents: .ValueChanged)
        self.contentView.addSubview(settingCellLabel)
        self.contentView.addSubview(settingCellSwitch)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .None
    }

    @IBAction func settingsCellSwitchChanged(sender: UISwitch!) {
        self.didTurnOnFacebook()
        if self.settingCellSwitch.on {
            retrieveMetaDataForOnSettings()
        }
        saveSwitchToAppSettings()
    }
    
    func saveSwitchToAppSettings() {
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
            DDLogError("Could not save \(error), \(error.userInfo)")
            
        }
    }
    
    func retrieveMetaDataForOnSettings() {
        
        switch self.settingCellLabel.text! {
            case "Facebook":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(FacebookPhotosAdapter())
            case "Photos":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(PhotoLibraryAdapter())
            case "Calendar Events":
                MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(CalendarLibraryAdapter())
            default:
                DDLogVerbose("No item selected")
        }
    }
    
    func didTurnOnFacebook() -> Bool {
        if self.settingCellLabel.text == "Facebook" && self.settingCellSwitch.on {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let fbLoginViewController = storyBoard.instantiateViewControllerWithIdentifier("FBLoginViewController")
            self.currentViewController.presentViewController(fbLoginViewController, animated: true, completion: nil)
            return true
        } else {
            return false
        }
    }
}
