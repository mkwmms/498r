//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class FBAdapter {
    
//    array of memorables
//    or add to memorableData or talk to singleton!!!
    
    func retrieveMetaData() -> Void {
        
        let parameters = ["fields": "picture.type(large),photos.type(uploaded){images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler {( connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            
            let resultImages = result.objectForKey("photos")!.objectForKey("data")!
            print ("resultImagesCount:", resultImages.count)
            print (resultImages)
            for (var i = 0; i < resultImages.count; i++) {
                
                let fbImageMetaData = resultImages[i].objectForKey("images")![0].objectForKey("source")
                
                let fbImageCreationDate = resultImages[i].objectForKey("created_time")!
                
                print("metadata:", fbImageMetaData!)
                print("creationDate:", fbImageCreationDate)
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)
                
                let memorable = FBMemorable(creationDate: date!, data: fbImageMetaData!)
                MemorableData.sharedInstance.allMemorablesArray.append(memorable)
            }
            
            let url = NSURL(string: (result.objectForKey("photos")!.objectForKey("data")![0].objectForKey("images")![0]!.objectForKey("source") as! String))
            
            let imageDataFromURL = NSData(contentsOfURL: url!)
            
            let fbImage = UIImage(data: imageDataFromURL!)
        }

    }
}