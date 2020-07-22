//
//  Section.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 22/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class Section {

    private var jsonDic: [String: Any]
    init(withDic dic: [String: Any]) {

        jsonDic = dic
    }

    private(set) lazy var attributes: [Attribute] = {
        guard let attributes = jsonDic[JSONConstants.Key.attributes] as? [[String: Any]] else {
            return [Attribute]()
        }
        return attributes.map { (dic) -> Attribute in
            return Attribute(withDic: dic)
        }
    }()

}
