//
//  MonthCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var monthCellImageView: UIImageView!
    
    func configureForItem(memorable: Any) {
//        let targetSize = CGSize(width: 200, height: 200)
//        if let mem = memorable as? Memorable {
//            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (image) -> Void in
//                // FIXME somehow this always takes the else branch even though it prints fine from the completion handler
//                if let img = image as? UIImage {
//                    debugPrint("MonthCollectionViewCell:", image)
//                    // FIXME monthCellImageView does not exist yet?
//                    self.monthCellImageView.image = img
//                    debugPrint("monthCellImage:", self.monthCellImageView)
//                } else {
//                    debugPrint("ERROR MonthCollectionViewCell:", image)
//                    self.backgroundColor = UIColor.redColor()
//                }
//            })
//        }
    }
}
