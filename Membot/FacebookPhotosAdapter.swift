//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class FacebookPhotosAdapter: Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> Void) {

        let parameters = ["fields": "picture.type(large),photos{images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }

            let resultImages = result.objectForKey("photos")!.objectForKey("data")!

            var facebookMemorables = [Memorable]()
            for var i = 0; i < resultImages.count; i++ {
                // FIXME largest image might not always be the first item
                print(resultImages[i].objectForKey("images")!)
                let fbImageMetadata = resultImages[i].objectForKey("images")![6].objectForKey("source")
                let fbImageCreationDate = resultImages[i].objectForKey("created_time")!

                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)

                facebookMemorables.append(MemorableFacebookPhoto(adapter: self, metadata: fbImageMetadata!, creationDate: date!))
            }
//            print("FBAdapter:", MemorableData.sharedInstance.getMemorablesByDay().count)
            completion(facebookMemorables)
//         collecitonView.numberOfSections(MemorableData.sharedInstance.getMemorablesByDay().count)
        }
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void) {
        let url = NSURL(string: source as! String)
        let imageDataFromURL = NSData(contentsOfURL: url!)
        
        let fbImage = UIImage(data: imageDataFromURL!)
        completion(fbImage as UIImage!)
    }
}