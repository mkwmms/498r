//
//  Adapter.swift
//  Membot
//
//  Created by Alex Andrews on 3/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

protocol Adapter {

    func retrieveMetadata(completion: ([Memorable]) -> Void)

    func retrieveDisplayableData(source: Any, dimensions: CGSize, completion: (Any) -> Void)
}

extension CGSize {
    func isWithin(amount: Int, from: CGSize) -> Bool {
        let amt = CGFloat(amount)

        let targetWidthMinus = from.width - amt
        let targetWidthPlus = from.width + amt
        if targetWidthMinus ... targetWidthPlus ~= self.width {
            return true
        }

        let targetHeightMinus = from.height - amt
        let targetHeightPlus = from.height + amt
        if targetHeightMinus ... targetHeightPlus ~= self.height {
            return true
        }

        return false
    }
}