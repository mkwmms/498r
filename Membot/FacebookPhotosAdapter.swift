//
//  FBAdapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import Haneke
import CocoaLumberjackSwift

class FacebookPhotosAdapter: Adapter {

    let cache = Shared.imageCache
    var count = 0

    func retrieveMetadata(completion: ([Memorable]) -> Void) {
//        var facebookMemorables = [Memorable]()
        recursivelyRetrieveMetadata(nil, completion: { (memorables) -> Void in
            print("in outer space: ", memorables)
            completion(memorables)
        })
    }

    func recursivelyRetrieveMetadata(nextCursor: String?, completion: ([Memorable]) -> Void) {
        var parameters = ["fields": "picture.type(large),photos{images, created_time}", "limit": "99"]
        if nextCursor != nil {
            parameters["after"] = nextCursor
        }
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            guard error == nil else {
                DDLogError("\(error?.localizedFailureReason) \(error?.localizedDescription)")
                return
            }
       
            let resultImages = result.objectForKey("photos")!.objectForKey("data")! as! [AnyObject]
//            print(resultImages.count)
            var facebookMemorables = [Memorable]()
            if self.count > 10 {
                print("in innner space: ", facebookMemorables)
                completion(facebookMemorables)
                return
            }
            for i in 0 ..< resultImages.count {
                let fbImage = resultImages[i]
                let resultMetadatas = resultImages[i].objectForKey("images")! as! [AnyObject]

                var fbImageMetadata = [MemorableFacebookMetadata]()
                for j in 0 ..< resultMetadatas.count {
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
//            print(result)

//            if let after = ((result.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors")
//                as? NSDictionary)?.objectForKey("after") as? String {
            if let after = result.objectForKey("photos")?.objectForKey("paging")?.objectForKey("cursors")?.objectForKey("after") as? String {
                self.count++
                print(self.count)
                self.recursivelyRetrieveMetadata(after, completion: { (memorables) -> Void in
//                    print(memorables)
                    facebookMemorables += memorables
//                    completion(facebookMemorables)
                })
            }
//            print(facebookMemorables)
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