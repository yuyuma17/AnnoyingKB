//
//  PushNotBySVViewController.swift
//  AnnoyingKB
//
//  Created by 黃士軒 on 2020/1/5.
//  Copyright © 2020 Lacie. All rights reserved.
//

import UIKit

class PushNotBySVViewController: UIViewController, UITextFieldDelegate {
    
    var currentTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        resignKeyboardNotifications()
    }
}

extension PushNotBySVViewController {
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func resignKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWasShown(_ aNotification: Notification?) {

        if currentTextField == nil {
            return
        }

        let info = aNotification?.userInfo

        guard let kbSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }

        let origin = (currentTextField?.frame.origin)!
        let height = (currentTextField?.frame.size.height)!
        let targetY = origin.y + height
        let visibleRectWithoutKeyboard = view.bounds.size.height - kbSize.height

        if targetY >= visibleRectWithoutKeyboard {
            var rect = view.bounds
    
            rect.origin.y -= (targetY - visibleRectWithoutKeyboard) + 10
            view.frame = rect
        }
    }
    
    @objc private func keyboardWillBeHidden() {
        view.frame = view.frame.offsetBy(dx: 0, dy: -view.frame.origin.y)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
         } else {
            textField.resignFirstResponder()
         }
        return true
    }
    
    private func addTapGesture() {
         let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
         view.addGestureRecognizer(tap)
     }
     
     @objc private func hideKeyboard() {
         view.endEditing(true)
     }
}
