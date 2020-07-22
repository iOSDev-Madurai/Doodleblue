//
//  ProtocolHelper.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 22/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

protocol KeyboardCustomDelegate {
    func didReceiveKeyboardSize(_ edge: UIEdgeInsets)
}

protocol TextFieldPickerDelegate {
    func didReceivedSelected(Option option: OptionValue)
}
