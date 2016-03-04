//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class FBAdapter: Adapter {
    
    func retrieveMetaData() -> Void {
        
        let parameters = ["fields": "picture.type(large),photos{images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler {( connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            let resultImages = result.objectForKey("photos")!.objectForKey("data")!

            for (var i = 0; i < resultImages.count; i++) {
                
                // FIXME largest image might not always be the first item
                
                let fbImageMetaData = resultImages[i].objectForKey("images")![0].objectForKey("source")
                let fbImageCreationDate = resultImages[i].objectForKey("created_time")!
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)
                
                let memorable = FBMemorable(creationDate: date!, data: fbImageMetaData!)
                MemorableData.sharedInstance.addMemorable(memorable)
            }
            print ("FBAdapter:",MemorableData.sharedInstance.getMemorablesByDay().count)

//         collecitonView.numberOfSections(MemorableData.sharedInstance.getMemorablesByDay().count)
        }
    }
    
    func retrieveData() {
        
        /*
        let url = NSURL(string: (result.objectForKey("photos")!.objectForKey("data")![0].objectForKey("images")![0]!.objectForKey("source") as! String))

        let imageDataFromURL = NSData(contentsOfURL: url!)

        let fbImage = UIImage(data: imageDataFromURL!)
        */
    }
}