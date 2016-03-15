//
//  MonthCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import Haneke

class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var monthCellImageView: UIImageView!

    func configureForItem(memorable: Any) {
        let targetSize = CGSize(width: 200, height: 200)
        if let mem = memorable as? Memorable {
            if let url = mem.metadata as? NSURL {
                monthCellImageView.hnk_setImageFromURL(url)
            } else {
                mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (image) -> Void in
                    self.monthCellImageView.image = image as? UIImage
                })
            }
        }
    }
}
