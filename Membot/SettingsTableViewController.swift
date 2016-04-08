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
    
    let navigationBar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64)
        navigationBar.autoresizingMask = .FlexibleWidth
        navigationBar.backgroundColor = UIColor(white:1, alpha: 0.5)
        let navigationItem = UINavigationItem()
        navigationItem.title = "Settings"

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.doneWithSettings(_:)))
        
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        self.tableView.registerClass(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64)
    }
    
    func doneWithSettings(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        <#code#>
//    }

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

        // see if the cell was fb and flagged as yes, if so, present view controller
//        if cell.didTurnOnFacebook() {
//            print("did turn on fb, presentviewcontroller")
//        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
