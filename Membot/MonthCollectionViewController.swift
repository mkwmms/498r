//
//  MonthCollectionViewController.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MonthCollectionCellIdentifier"

class MonthCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var monthDataSource: MonthCollectionViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Init our datasource and setup the closure to handle our cell
        monthDataSource = MonthCollectionViewDataSource(cellIdentifier: reuseIdentifier, configureBlock: { (cell, memorable) -> Void in
            if let actualCell = cell as? MonthCollectionViewCell {
                if let mem = memorable as? Memorable {
                    actualCell.configureForItem(mem)
                }
            }
        })

        monthDataSource?.sortMemorablesByMonth()

        collectionView!.dataSource = monthDataSource

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(MonthCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - FlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = UIScreen.mainScreen().bounds.width / 5
        return CGSize(width: cellSize, height: cellSize)
    }
}
