//
//  DayCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    func addImageToCell() {
        let image = UIImage(named: "peaches")
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
    }
    
    func configureForItem(memorable: Any) {
        let targetWidth = UIScreen.mainScreen().bounds.width
        let targetSize = CGSize(width: targetWidth, height: targetWidth)
        let dayImageView: UIImageView = UIImageView()
        if let mem = memorable as? Memorable {
            if let url = mem.metadata as? NSURL {
                dayImageView.hnk_setImageFromURL(url)
            } else {
                mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (image) -> Void in
                    dayImageView.image = image as? UIImage
                })
            }
        }
        self.addSubview(dayImageView)
        self.addImageToCell()
    }
    
}
