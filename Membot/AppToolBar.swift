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
        toolBarItemSettings.width = 44
        
        toolBarItemSettings.target = self
        toolBarItemCompose.target = self
//        toolBarItemSettings.action = #selector(self.displaySettingsController(_:))
        toolBarItemCompose.action = #selector(self.displayComposeMemorableController(_:))
        self.setItems([flexibleSpaceBar1, toolBarItemSettings, flexibleSpaceBar2, toolBarItemCompose, flexibleSpaceBar3], animated: false)
        self.backgroundColor = UIColor(white: 1, alpha: 0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayComposeMemorableController(sender: UIBarButtonItem) {
        let composeMemorableViewController = ComposeMemorableViewController()
        currentViewController.presentViewController(composeMemorableViewController, animated: true, completion: nil)
        
        print("apples")
    }
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}