//
//  ComposeMemorableViewController.swift
//  Membot
//
//  Created by Alex Andrews on 4/5/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import CoreData
import CocoaLumberjackSwift

class ComposeMemorableViewController: UIViewController, UITextViewDelegate {
    
    var previousViewController = UICollectionViewController()
    let navigationBar = UINavigationBar()
    let memorableComposition = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displaySubviews()
        
        // memorableComposition.delegate = self
        memorableComposition.backgroundColor = UIColor.whiteColor()
        memorableComposition.returnKeyType = UIReturnKeyType.Done
        memorableComposition.font = UIFont.systemFontOfSize(UIFont.labelFontSize())
        memorableComposition.becomeFirstResponder()
        memorableComposition.autoresizingMask = .FlexibleWidth
        memorableComposition.scrollEnabled = true
        
        self.view!.addSubview(memorableComposition)
        
        navigationBar.backgroundColor = UIColor(white: 1, alpha: 0.5)
        navigationBar.autoresizingMask = .FlexibleWidth
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Compose Entry"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain,
                                           target: self, action: #selector(self.cancelComposition(_:)))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain,
                                         target: self, action: #selector(self.doneWithComposition(_:)))
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransitionToSize(size: CGSize,
                                           withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.displaySubviews()
    }
    
    func displaySubviews() {
        if UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft
            || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight {
            
            self.navigationBar.frame = CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.mainScreen().bounds.width,
                                              height: 32)
            
            self.memorableComposition.frame = CGRect(x: 0,
                                                     y: 32,
                                                     width: UIScreen.mainScreen().bounds.width,
                                                     height: UIScreen.mainScreen().bounds.height - 32)
            
        } else if UIDevice.currentDevice().orientation == UIDeviceOrientation.PortraitUpsideDown
            || UIDevice.currentDevice().orientation == UIDeviceOrientation.Portrait {
            
            self.navigationBar.frame = CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.mainScreen().bounds.width, height: 64)
            
            self.memorableComposition.frame = CGRect(x: 0,
                                                     y: 64,
                                                     width: UIScreen.mainScreen().bounds.width,
                                                     height: UIScreen.mainScreen().bounds.height - 64)
        }
    }
    
    func cancelComposition(sender: UIBarButtonItem) {
        self.memorableComposition.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneWithComposition(sender: UIBarButtonItem) {
        saveCompositionToCoreData()
        self.memorableComposition.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveCompositionToCoreData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("Composition",
                                                                  inManagedObjectContext: managedContext)
        
        let compositionEntity = NSManagedObject(entity: entityDescription!,
                                                insertIntoManagedObjectContext: managedContext)
        
        compositionEntity.setValue(self.memorableComposition.text, forKey: "compositionText")
        compositionEntity.setValue(NSDate(), forKey: "compositionDate")
        
        do {
            try managedContext.save()
            MemorableMetadataCache.sharedInstance.retrieveMetadataFrom(CompositionAdapter())
        } catch let error as NSError {
            DDLogError("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("itza marrio")
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
