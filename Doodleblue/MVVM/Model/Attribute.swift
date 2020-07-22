//
//  Attribute.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class Attribute {

    private var jsonDic: [String: Any]
    init(withDic dic: [String: Any]) {

        jsonDic = dic
    }
    
    lazy var id: String = {
        return jsonDic[JSONConstants.Key.attributeId] as? String ?? Constants.empty
    }()
    
    lazy var label: String = {
        return jsonDic[JSONConstants.Key.modifiedLabel] as? String ?? Constants.empty
    }()
    
    lazy var tag: String = {
        return jsonDic[JSONConstants.Key.tag] as? String ?? Constants.empty
    }()

    private lazy var dataList: [OptionValue] = {
        guard
            let attributes = jsonDic[JSONConstants.Key.optionValueList] as? [[String: Any]]
            else {
                return [OptionValue]()
        }
        return attributes.map { (dic) -> OptionValue in
            return OptionValue(withDic: dic)
        }
    }()

    var options: [OptionValue] {
        guard
            let dependent = dependentAttributes
            else {
                return dataList
        }
        let filteredData = dataList.filter { (option) -> Bool in
            guard let _ = dependent.first(where: { (attribute) -> Bool in
                guard let selected = attribute.selectedData else {
                    return false
                }
                return selected.id.elementsEqual(option.id)
            }) else {
                return true
            }
            return false
        }
        return filteredData
    }

    weak var selectedData: OptionValue?
    var dependentAttributes: [Attribute]?

}


