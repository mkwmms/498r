//
//  DayCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import EventKit
import CocoaLumberjackSwift

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayCollectionCellImage: UIImageView!
    @IBOutlet weak var dayCollectionCellLabel: UILabel!

    func configureForItem(memorable: Any) {
        
        let targetSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        if let mem = memorable as? Memorable {
            if let memEvent = mem.metadata as? EKEvent {
                self.dayCollectionCellImage.hidden = true
                self.dayCollectionCellLabel.hidden = false
                self.dayCollectionCellLabel.text = memEvent.title
                self.dayCollectionCellImage.sizeToFit()
                self.dayCollectionCellLabel.center = self.contentView.center
                DDLogVerbose("Title: " + memEvent.title)
                return
            } else if let memComposition = mem.metadata as? String {
                self.dayCollectionCellImage.hidden = true
                self.dayCollectionCellLabel.hidden = false
                self.dayCollectionCellLabel.text = memComposition
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
