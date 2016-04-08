//
//  SettingsTableViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/10/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appSettings = AppSettings.sharedInstance.settings
    let reuseIdentifier = "SettingsTableViewCell"
    var tableView = UITableView()
    let navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64)
        navigationBar.autoresizingMask = .FlexibleWidth
        navigationBar.backgroundColor = UIColor(white:1, alpha: 0.5)
        let navigationItem = UINavigationItem()
        navigationItem.title = "Settings"
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItemStyle.Plain,
                                         target: self, action: #selector(self.doneWithSettings(_:)))
        
        navigationItem.rightBarButtonItem = doneButton
        navigationBar.items = [navigationItem]
        
        self.tableView.registerClass(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.frame = CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64)
        self.tableView.autoresizingMask = .FlexibleWidth
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(navigationBar)
        self.view.addSubview(tableView)
    }
    
    func doneWithSettings(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppSettings.sharedInstance.settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SettingsTableViewCell
        
        cell.currentViewController = self
        cell.settingCellLabel.text = AppSettings.sharedInstance.settings[indexPath.item].displayableName
        cell.settingCellSwitch.on = AppSettings.sharedInstance.settings[indexPath.item].isOn
        
        return cell
    }
}
