//
//  DayCollectionViewCell.swift
//  Membot
//
//  Created by Alex Andrews on 3/1/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import EventKit
import Photos
import CocoaLumberjackSwift

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayCollectionCellImage: UIImageView!
    @IBOutlet weak var dayCollectionCellLabel: UILabel!
    var dayCollectionCellTextView: UITextView!
    
    let timeView = UIView()
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()
    let descriptionView = UIView()
    let descriptionLabel = UILabel()
    let divider = UIView()
    let compositionEntry = UILabel()

    func configureForItem(memorable: Any) {
        
        let targetSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
        if let mem = memorable as? Memorable {
            if let memEvent = mem.metadata as? EKEvent {
                
                self.timeView.hidden = false
                self.descriptionView.hidden = false
                self.divider.hidden = false
                self.compositionEntry.hidden = true
                
                if memEvent.allDay {
                    startTimeLabel.text = "all-day"
                    endTimeLabel.hidden = true
                } else {
                    startTimeLabel.text = memEvent.startDate.timeDescription()
                    endTimeLabel.text = memEvent.endDate.timeDescription()
                    endTimeLabel.hidden = false
                }
                
                timeView.addSubview(startTimeLabel)
                timeView.addSubview(endTimeLabel)
                
                descriptionLabel.text = memEvent.title
                descriptionView.addSubview(descriptionLabel)
                
                self.contentView.addSubview(timeView)
                self.contentView.addSubview(descriptionView)
                self.contentView.addSubview(divider)
                
                timeView.frame = CGRect(x: 10, y: 0, width: UIScreen.mainScreen().bounds.width / 5, height: 50)
                startTimeLabel.adjustsFontSizeToFitWidth = true
                endTimeLabel.adjustsFontSizeToFitWidth = true
                startTimeLabel.frame = CGRect(x: 0, y: 5, width: timeView.bounds.width, height: 20)
                endTimeLabel.frame = CGRect(x: 0, y: 25, width: timeView.bounds.width, height: 20)
                
                descriptionView.frame = CGRect(x: UIScreen.mainScreen().bounds.width / 3, y: 0, width: UIScreen.mainScreen().bounds.width - UIScreen.mainScreen().bounds.width / 4, height: 50)
                
                descriptionLabel.frame = CGRect(x: 0, y: 0, width: descriptionView.bounds.width, height: 50)
                descriptionLabel.adjustsFontSizeToFitWidth = true
                descriptionLabel.textAlignment = .Left
                
                divider.frame = CGRect(x: UIScreen.mainScreen().bounds.width / 4, y: 5, width: 2, height: 45)
                divider.backgroundColor = UIColor.lightGrayColor()
                
                self.dayCollectionCellImage.hidden = true
                self.dayCollectionCellLabel.hidden = true
                DDLogVerbose("Title: " + memEvent.title)
                return
            } else if let memComposition = mem.metadata as? String {
                self.dayCollectionCellImage.hidden = true
                self.dayCollectionCellLabel.hidden = true
                self.divider.hidden = true
                self.dayCollectionCellLabel.text = memComposition
                self.dayCollectionCellTextView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
                self.dayCollectionCellTextView.sizeToFit()
                self.dayCollectionCellTextView.layoutIfNeeded()
                self.dayCollectionCellTextView.textAlignment = .Left
//                self.dayCollectionCellTextView.
//                self.addSubview(self.dayCollectionCellTextView)
                
                compositionEntry.text = memComposition
                self.contentView.addSubview(compositionEntry)
                compositionEntry.frame = CGRect(x: 10, y: 0, width: 300, height: 300)
                compositionEntry.numberOfLines = 8
                compositionEntry.layer.borderColor = UIColor.lightGrayColor().CGColor
                compositionEntry.layer.borderWidth = 1
                
                //                self.dayCollectionCellTextView.text = memComposition
//                self.dayCollectionCellTextView.center = self.contentView.center
//                self.contentView.addSubview(dayCollectionCellTextView)
                return
            }
            
            mem.adapter.retrieveDisplayableData(mem.metadata, dimensions: self.sizeThatFits(targetSize), completion: { (result) -> Void in
                
                if let photosMem = mem.metadata as? PHAsset {
                    print("photos")
                } else {
                    print("fb")
                }
                if let resultImage = result as? UIImage {
                    self.timeView.hidden = true
                    self.descriptionView.hidden = true
                    self.dayCollectionCellLabel.hidden = true
                    self.compositionEntry.hidden = true
                    self.divider.hidden = true
                    self.dayCollectionCellImage.hidden = false
                    self.dayCollectionCellImage.contentMode = .ScaleAspectFit
                    self.dayCollectionCellImage.image = resultImage
                }
            })
        }
    }
}
