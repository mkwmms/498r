//
//  AppToolBar.swift
//  Membot
//
//  Created by Alex Andrews on 4/5/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class AppToolBar: UIToolbar {
    
    var currentViewController: UICollectionViewController = UICollectionViewController()
    let flexibleSpaceBar1 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let flexibleSpaceBar2 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let flexibleSpaceBar3 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    let toolBarItemCompose = UIBarButtonItem(barButtonSystemItem: .Compose, target: nil, action: nil)
    let toolBarItemSettings = UIBarButtonItem(image: UIImage(named: "Settings"), style: .Plain, target: nil, action: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        toolBarItemSettings.width = 44
        
        toolBarItemSettings.target = self
        toolBarItemCompose.target = self
        toolBarItemSettings.action = #selector(self.displaySettingsController(_:))
        toolBarItemCompose.action = #selector(self.displayComposeMemorableController(_:))
        self.setItems([flexibleSpaceBar1, toolBarItemSettings, flexibleSpaceBar2, toolBarItemCompose, flexibleSpaceBar3], animated: false)
        self.backgroundColor = UIColor(white: 1, alpha: 0.1)
        self.autoresizingMask = .FlexibleWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayComposeMemorableController(sender: UIBarButtonItem) {
        let composeMemorableViewController = ComposeMemorableViewController()
//        composeMemorableViewController.previousViewController = currentViewController
        currentViewController.presentViewController(composeMemorableViewController, animated: true, completion: nil)
    }
    
    func displaySettingsController(sender: UIBarButtonItem) {
//        let settingsTableViewController = SettingsTableViewController()
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let settingsTableViewController = storyBoard.instantiateViewControllerWithIdentifier("SettingsTableViewController")
//        currentViewController.presentViewController(settingsTableViewController, animated: true, completion: nil)
        let settingsTableViewController = SettingsTableViewController()
        self.currentViewController.presentViewController(settingsTableViewController, animated: true, completion: nil)
    }
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}