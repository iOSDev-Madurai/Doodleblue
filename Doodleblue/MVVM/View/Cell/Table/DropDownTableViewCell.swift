//
//  DropDownTableViewCell.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell, TextFieldPickerDelegate, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    // Properties
    var attribute: Attribute? {
        didSet {
            setTextFieldValues()
        }
    }

    // MARK:- Init

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.clearButtonMode = .unlessEditing
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setTextFieldValues() {
        guard let attribute = attribute else { return }
        titleLabel.text = attribute.label
        if textField.inputView == nil {
            textField.inputView = TextFieldPickerView(withTextField: textField, Delegate: self, LayoutInfo: attribute)
        }
        if let selected = attribute.selectedData {
            textField.text = selected.name
        }
    }

    // MARK:- UITextFieldDelegate

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        attribute?.selectedData = nil
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
         guard
            let pickerView = textField.inputView as? TextFieldPickerView,
            let attribute = attribute
            else {
                return
        }
        pickerView.options = attribute.options
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        setAttributeValue()
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        setAttributeValue()
        return true
    }

    private func setAttributeValue() {
        guard let text = textField.text, !text.isEmpty else { return }
        attribute?.selectedData = attribute?.options.first(where: { (option) -> Bool in
            return option.name == text
        })
    }

    // MARK:- TextFieldPickerDelegate

    func didReceivedSelected(Option option: OptionValue) {

        textField.text = option.name
        setAttributeValue()
    }

}
