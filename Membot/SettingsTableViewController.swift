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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppSettings.sharedInstance.settings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SettingsTableViewCell

        cell.settingCellLabel.text = AppSettings.sharedInstance.settings[indexPath.item].displayableName
        cell.settingCellSwitch.on = AppSettings.sharedInstance.settings[indexPath.item].isOn

        return cell
    }

//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    }
}
