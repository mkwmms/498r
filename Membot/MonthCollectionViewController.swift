//
//  MonthCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MonthCollectionCellIdentifier"

class MonthCollectionViewController: UICollectionViewController {

    var dataSource: MonthCollectionViewDataSource?

//    override func viewWillAppear(animated: Bool) {
//        code
//    }
//    
//    override func viewDidappear(animated: bool) {
//        dataSource!.addMetaDataFrom(collectionView!, adapter: FBAdapter())
//        dataSource!.addMetaDataFrom(collectionView!, adapter: CalendarLibraryAdapter())
//        dataSource!.addMetaDataFrom(collectionView!, adapter: PhotoLibraryAdapter())
//
//    }
    
    override func viewDidLoad() {
        
        print("in month controller")

        // Init our datasource and setup the closure to handle our cell
        // FIXME
        self.dataSource = MonthCollectionViewDataSource(cellIdentifier: reuseIdentifier, configureBlock: { (cell, memorable) -> () in
            if let actualCell = cell as? MonthCollectionViewCell {
                if let mem = memorable as? Memorable {
                    actualCell.configureForItem(mem)
                }
            }
        })

//        dataSource!.addMetaDataFrom(collectionView!, adapter: FBAdapter())
        dataSource!.addMetaDataFrom(collectionView!, adapter: CalendarLibraryAdapter())
        dataSource!.addMetaDataFrom(collectionView!, adapter: PhotoLibraryAdapter())

        collectionView!.dataSource = self.dataSource
        collectionView!.backgroundColor = UIColor.grayColor()

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
         self.collectionView!.registerClass(MonthCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: UICollectionViewDelegate

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }

     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }

     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {

     }
     */
}
