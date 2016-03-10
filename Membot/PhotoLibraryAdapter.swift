//
//  PhotoLibraryAdapter.swift
//  Membot
//
//  Created by William Myers on 3/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import Photos

class PhotoLibraryAdapter: Adapter {
    let manager = PHImageManager.defaultManager()

    func retrieveMetaData(completion: ([Memorable]) -> ()) {
        let assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        var photoMemorables = [Memorable]()
        assets.enumerateObjectsUsingBlock({ (obj, index, stop) in
            // TODO add extension to PHFetchResult so we don't have to enumerate these objects and just add them directly?
            if let asset = obj as? PHAsset {
                photoMemorables.append(MemorablePhoto(date: asset.creationDate!, data: asset))
            }
        })
        completion(photoMemorables)
        // call this callback within some kind of Photos callback?
    }

    func retrieveData(completed: ([Memorable]) -> ()) {
        // TODO
        /*
         manager.requestImageForAsset(asset, targetSize: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height), contentMode: .AspectFit, options: nil, resultHandler: { (result, info) -> Void in
         photo = result!
         })
         */
    }
    
}