//
//  DayCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    func configureForItem(memorable: Any) {
        
//        self.backgroundColor = UIColor.lightGrayColor()
        
        let screenSize = UIScreen.mainScreen().bounds
        let imageTargetSize = UIScreen.mainScreen().bounds
        let targetSize = CGSize(width: imageTargetSize.width, height: imageTargetSize.width)
        if let mem = memorable as? Memorable {
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (image) -> Void in
                let dayImageView: UIImageView = UIImageView(image: image as? UIImage)
                dayImageView.frame = CGRectMake(0,0, screenSize.height * 0.9, screenSize.width * 0.9)
                dayImageView.contentMode = .ScaleAspectFit
                self.contentView.addSubview(dayImageView)
            })
        }
    }
}
