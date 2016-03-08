//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class FBAdapter: Adapter {

    func retrieveMetaData(completion: ([Memorable]) -> ()) {

        let parameters = ["fields": "picture.type(large),photos{images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                print(error)
                return
            }

            let resultImages = result.objectForKey("photos")!.objectForKey("data")!

            var facebookMemorables = [Memorable]()
            for var i = 0; i < resultImages.count; i++ {
                // FIXME largest image might not always be the first item
                let fbImageMetaData = resultImages[i].objectForKey("images")![0].objectForKey("source")
                let fbImageCreationDate = resultImages[i].objectForKey("created_time")!

                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)

                facebookMemorables.append(FBMemorable(creationDate: date!, data: fbImageMetaData!))
            }
//            print("FBAdapter:", MemorableData.sharedInstance.getMemorablesByDay().count)
            completion(facebookMemorables)
//         collecitonView.numberOfSections(MemorableData.sharedInstance.getMemorablesByDay().count)
        }
    }

    func retrieveData(completion: ([Memorable]) -> ()) {
        /*
         let url = NSURL(string: (result.objectForKey("photos")!.objectForKey("data")![0].objectForKey("images")![0]!.objectForKey("source") as! String))

         let imageDataFromURL = NSData(contentsOfURL: url!)

         let fbImage = UIImage(data: imageDataFromURL!)
         */
    }
}