//
//  MemorableCompositionAdapter.swift
//  Membot
//
//  Created by William Myers on 4/8/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import CoreData
import CocoaLumberjackSwift

class CompositionAdapter: Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: "Composition")
        var coreDataCompositions = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        var memorableCompositions = [Memorable]()
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            coreDataCompositions = results as! [NSManagedObject]
            if coreDataCompositions.count > 0 {
                for composition in coreDataCompositions {
//                    memorableCompositions.
                    let date = composition.valueForKey("compositionDate") as! NSDate
                    let text = composition.valueForKey("compositionText") as! String
                    let id = date.timeIntervalSince1970.description // TODO make this more bulletproof
                    let mem = MemorableComposition(uniqueId: id, adapter: self, metadata: text, creationDate: date)
                    DDLogVerbose(mem.debugDescription)
                    memorableCompositions.append(mem)
                }
            }
        } catch let error as NSError {
            DDLogError("Could not fetch \(error), \(error.userInfo)")
        }
    }

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void) {
        // TODO?
    }
}
