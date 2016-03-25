//
//  DayCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import EventKit

class DayCollectionViewCell: UICollectionViewCell {
    
    var dayCollectionCellImage = UIImageView(image: UIImage(named: "peaches"))
    var dayCollectionCellLabel = UILabel()
    
    func setUpViews() {
        self.addSubview(self.dayCollectionCellImage)
        self.addSubview(self.dayCollectionCellLabel)
        print("Subviews:", self.contentView.subviews.count)

    }
    
    func configureForItem(memorable: Any) {


        self.contentView.subviews.forEach({ $0.removeFromSuperview() })
        
        if let mem = memorable as? Memorable {
            if let memEvent = mem.metadata as? EKEvent {
                self.dayCollectionCellImage.hidden = true
                let eventLabel = UILabel()
                eventLabel.text = memEvent.title
                self.dayCollectionCellLabel.center = self.contentView.center
                return
            }

            let targetSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (result) -> Void in

                self.dayCollectionCellLabel.hidden = true
                self.dayCollectionCellImage.image = result as? UIImage
//                let dayCollectionCellImage = UIImageView(image: result as! UIImage)
                self.dayCollectionCellImage.contentMode = .ScaleAspectFit
                self.dayCollectionCellImage.center = self.contentView.center
            })
        }
        print("Subviews:", self.contentView.subviews.count)
    }
}
