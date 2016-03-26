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

    @IBOutlet weak var dayCollectionCellImage: UIImageView!
    @IBOutlet weak var dayCollectionCellLabel: UILabel!

    func configureForItem(memorable: Any) {
        
        let targetSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        if let mem = memorable as? Memorable {
            
            if let memEvent = mem.metadata as? EKEvent {
                self.dayCollectionCellImage.hidden = true
                self.dayCollectionCellLabel.hidden = false
                self.dayCollectionCellLabel.text = memEvent.title + " " + (memEvent.creationDate?.dayDescription())!
                self.dayCollectionCellImage.sizeToFit()
                self.dayCollectionCellLabel.center = self.contentView.center
                print("Title:", memEvent.title)
                return
            }
            
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (result) -> Void in
                
                if let resultImage = result as? UIImage {
                    self.dayCollectionCellLabel.hidden = true
                    self.dayCollectionCellImage.hidden = false
                    self.dayCollectionCellImage.contentMode = .ScaleAspectFit
                    self.dayCollectionCellImage.image = resultImage
                }
            })
        }
    }
}
