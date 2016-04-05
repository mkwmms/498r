//
//  ComposeMemorableViewController.swift
//  Membot
//
//  Created by Alex Andrews on 4/5/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class ComposeMemorableViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memorableEntry = UITextField(frame: UIScreen.mainScreen().bounds)
        memorableEntry.backgroundColor = UIColor(white: 1, alpha: 0.5)
        memorableEntry.returnKeyType = UIReturnKeyType.Done
        memorableEntry.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        memorableEntry.becomeFirstResponder()

//        let textFieldFrame = CGRect(x: UIScreen.mainScreen().bounds.maxX, y: UIScreen.mainScreen().bounds.maxY, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height + 100)
//        let memorableEntry = UITextView(frame: textFieldFrame)
//        memorableEntry.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        memorableEntry.becomeFirstResponder()

        
        self.view!.addSubview(memorableEntry)
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take the status bar into account

        navigationBar.backgroundColor = UIColor(white:1, alpha: 0.5)
//        navigationBar.delegate = self;
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Comopse Entry"
        
        let backButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(self.btn_clicked(_:)))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = doneButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btn_clicked(sender: UIBarButtonItem) {
        print("wrinkly")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("kwi gon gin")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("kwi gon gin2")
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
