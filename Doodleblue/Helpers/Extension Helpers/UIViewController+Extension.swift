//
//  UIViewController+Extension.swift
//  Doodleblue
//
//  Created by Jegadeeswaran on 22/07/20.
//  Copyright © 2020 Jegadeeswaran. All rights reserved.
//

import UIKit


extension UIViewController {

    //MARK:- Close Keyboard by touching anywhere in view

    func hideKeyboardWhenTappedAround() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK:- KeyBoard

    var keyboardDelegate: KeyboardCustomDelegate? {
        get {
            return objc_getAssociatedObject(self, &StoredKey.keyboardDelegate) as? KeyboardCustomDelegate
        } set (value) {
            objc_setAssociatedObject(self, &StoredKey.keyboardDelegate, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func registerKeyboardNotification() {

        hideKeyboardWhenTappedAround()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(observer:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(observer:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardNotification() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboard(observer aNotification: Notification) {

        guard let delegate = keyboardDelegate else { return }
        var contentInset = UIEdgeInsets.zero
        if aNotification.name == UIResponder.keyboardWillShowNotification,
            let userInfo = aNotification.userInfo,
            let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.cgRectValue.height
                + 20.0, right: 0)
        }
        delegate.didReceiveKeyboardSize(contentInset)
    }
}
