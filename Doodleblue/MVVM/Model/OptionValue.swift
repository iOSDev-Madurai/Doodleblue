//
//  DropDown.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class OptionValue {

    private var jsonDic: [String: Any]
    init(withDic dic: [String: Any]) {

        jsonDic = dic
    }

    private(set) lazy var id: String = {
        return jsonDic[JSONConstants.Key.optionId] as? String ?? ""
    }()

    private(set) lazy var name: String = {
        return jsonDic[JSONConstants.Key.optionObject] as? String ?? ""
    }()

}
