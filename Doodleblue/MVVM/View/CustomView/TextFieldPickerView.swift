//
//  TextFieldPickerView.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 21/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit

class TextFieldPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    // This Property
    private var textField: UITextField!
    private var textFieldDelegate: TextFieldPickerDelegate!
    private var attribute: Attribute!
    private var selectedPickerValue: OptionValue?
    private var keyboardDoneButtonView: UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        let done = UIBarButtonItem(title: Constants.done, style: .done, target: self, action: #selector(self.doneButtonTouched))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: Constants.cancel, style: .done, target: self, action: #selector(self.cancelButtonTouched))
        toolBar.setItems([cancel, flexibleSpace,done], animated: true)
        return toolBar
    }

    // MARK: - init

    init(withTextField txtField: UITextField,
            Delegate textDelegate: TextFieldPickerDelegate,
                LayoutInfo info: Attribute) {
        super.init(frame: CGRect.zero)

        textField                       = txtField
        textFieldDelegate               = textDelegate
        textField.inputAccessoryView    = keyboardDoneButtonView
        attribute                       = info
        delegate                        = self
        dataSource                      = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK:- Actions

    @objc private func doneButtonTouched() {

        textField.resignFirstResponder()
        guard
            let pickerValue = selectedPickerValue ?? attribute.options.first
            else {
                return
        }
        textFieldDelegate.didReceivedSelected(Option: pickerValue)
    }

    @objc private func cancelButtonTouched() {

        textField.resignFirstResponder()
    }
    
    // MARK:- UIPickerViewDelegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return attribute.options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        guard let pickerValue = attribute.options[safe: row] else { return nil }
        return pickerValue.name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard let pickerValue = attribute.options[safe: row] else { return }
        selectedPickerValue = pickerValue
    }

}
