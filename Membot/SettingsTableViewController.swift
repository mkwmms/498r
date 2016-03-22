//
//  SettingsTableViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

class SettingsTableViewController: UITableViewController {

    let appSettings = AppSettings.sharedInstance.settings
    let reuseIdentifier = "SettingsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SUPREME HACK
//        MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(FacebookPhotosAdapter())
//        MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(CalendarLibraryAdapter())
//        MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(PhotoLibraryAdapter())
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppSettings.sharedInstance.settings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SettingsTableViewCell
        
        cell.settingCellLabel.text = AppSettings.sharedInstance.settings[indexPath.item].displayableName
        cell.settingCellSwitch.on = AppSettings.sharedInstance.settings[indexPath.item].isOn

        // see if the cell was fb and flagged as yes, if so, present view controller
        if cell.didTurnOnFacebook() {
            DDLogVerbose("Did turn on fb, presentviewcontroller")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
