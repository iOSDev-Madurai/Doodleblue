//
//  Collection+Extension.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import Foundation

extension Collection {

    subscript(safe i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }

}
