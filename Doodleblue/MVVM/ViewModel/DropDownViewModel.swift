//
//  DropDownViewModel.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class DropDownViewModel: NSObject {

    private(set) lazy var attributes: [Attribute] = {
        return getAttributes()
    }()

    private func getAttributes() -> [Attribute] {
        guard
            let json = AppUtility.shared.getJSONValueFrom(File: JSONConstants.Key.attributes)
            else {
                return [Attribute]()
        }
        let section = Section(withDic: json.json)
        var attributes = section.attributes
        for index in 0..<attributes.count {
            let attribute = attributes[index]
            attribute.dependentAttributes = attributes.filter({ (localAttribute) -> Bool in
                return !localAttribute.id.elementsEqual(attribute.id)
            })
            attributes.remove(at: index)
            attributes.insert(attribute, at: index)
        }
        return attributes
    }

}
