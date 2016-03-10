//
//  Adapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

protocol Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> ())

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> ())
}