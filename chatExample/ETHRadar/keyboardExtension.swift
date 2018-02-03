//
//  keyboardExtension.swift
//  chatExample
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

protocol keyboardAnimations {
    func animateKeyboardChange(height: Float)
}

protocol keyboardRegistration {
    func registerForKeyboard()
    func deregisterKeyboard()
}

extension UIViewController : keyboardRegistration {
    func registerForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let controller = self as? keyboardAnimations {
            if let info = notification.userInfo {
                let keyboardFrame : CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let newBottomDistance = Float(keyboardFrame.size.height)
                controller.animateKeyboardChange(height: newBottomDistance)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let controller = self as? keyboardAnimations {
            if let info = notification.userInfo {
                let keyboardFrame : CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let newBottomDistance = 0 - Float(keyboardFrame.size.height)
                controller.animateKeyboardChange(height: newBottomDistance)
            }
        }
    }
}
