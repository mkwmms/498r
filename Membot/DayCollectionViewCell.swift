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

    
    func configureForItem(memorable: Any) {
        
        let screenSize = UIScreen.mainScreen().bounds
        let imageTargetSize = UIScreen.mainScreen().bounds
        let targetSize = CGSize(width: imageTargetSize.width, height: imageTargetSize.width)
        if let mem = memorable as? Memorable {
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (result) -> Void in
                
                if let memorableEvent = memorable as? MemorableCalendarEvent {
                    if let eventDescription = memorableEvent.metadata as? EKEvent {
                        print ("Description:",eventDescription.title)

//                        self.dayCollectionCellImage.removeFromSuperview()
                    }
                } else {
//                    self.dayCollectionCellLabel.removeFromSuperview()
                    self.dayCollectionCellImage.contentMode = .ScaleAspectFill
                    self.dayCollectionCellImage.image = result as? UIImage
                }
            })
        }
    }
}
