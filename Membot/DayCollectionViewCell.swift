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

//        let screenSize = UIScreen.mainScreen().bounds
//        let imageTargetSize = UIScreen.mainScreen().bounds
//        let targetSize = CGSize(width: imageTargetSize.width, height: imageTargetSize.width)
        let targetSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        if let mem = memorable as? Memorable {
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (result) -> Void in

                if let memorableEvent = memorable as? MemorableCalendarEvent {
                    if let eventDescription = memorableEvent.metadata as? EKEvent {
                        let eventLabel = UILabel()
                        eventLabel.text = eventDescription.title
                        self.contentView.addSubview(eventLabel)
                        self.dayCollectionCellImage.hidden = true
                    }
                } else if let mem = memorable as? MemorablePhoto {
                    self.dayCollectionCellImage.contentMode = .ScaleAspectFit
                    self.dayCollectionCellImage.image = result as? UIImage
                    if let resultImage = result as? UIImage {
                        print("Width:", resultImage.size.width, "Height:", resultImage.size.height)
                    }
                } else if let mem = memorable as? MemorableFacebookPhoto {
                    self.dayCollectionCellImage.contentMode = .ScaleAspectFit
                    self.dayCollectionCellImage.image = result as? UIImage
                    if let resultImage = result as? UIImage {
                        print("Width:", resultImage.size.width, "Height:", resultImage.size.height)
                    }
                }
            })
        }
    }
}
