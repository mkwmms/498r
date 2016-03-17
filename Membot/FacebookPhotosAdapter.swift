//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import Haneke

class FacebookPhotosAdapter: Adapter {

    let cache = Shared.imageCache

    func retrieveMetadata(completion: ([Memorable]) -> Void) {

        let parameters = ["fields": "picture.type(large),photos{images, created_time}"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            guard error == nil else {
                print(error)
                return
            }

            let resultImages = result.objectForKey("photos")!.objectForKey("data")!

            var facebookMemorables = [Memorable]()
            for var i = 0; i < resultImages.count; ++i {
                let fbImage = resultImages[i]
                let resultMetadatas = resultImages[i].objectForKey("images")!

                var fbImageMetadata = [MemorableFacebookMetadata]()
                for var j = 0; j < resultMetadatas.count; ++j {
                    // FIXME lots of sketchy casting is going down here
                    let metadata = resultMetadatas[j]
                    let width = metadata.objectForKey("width") as! Double
                    let height = metadata.objectForKey("height") as! Double
                    let size = CGSize(width: width, height: height)
                    let source = NSURL(string: metadata.objectForKey("source") as! String)
                    fbImageMetadata.append(MemorableFacebookMetadata(source: source!, size: size))
                }

                let fbImageCreationDate = fbImage.objectForKey("created_time")!
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatter.dateFromString(fbImageCreationDate as! String)

                if let fbIdentifier = fbImage.objectForKey("id") as? String {
                    facebookMemorables.append(MemorableFacebookPhoto(uniqueId: fbIdentifier,
                        adapter: self, metadata: fbImageMetadata, creationDate: date!))
                }
            }
            completion(facebookMemorables)
        }
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void) {

        if let metadata = source as? [MemorableFacebookMetadata] {
            var url = metadata[0].source // TODO have a "smarter" default
            for meta in metadata {
                if meta.size.isWithin(100, from: dimensions) {
                    url = meta.source
                    break // match on first found
                }
            }
            cache.fetch(URL: url).onSuccess { image in
                completion(image)
            }
        }
    }
}