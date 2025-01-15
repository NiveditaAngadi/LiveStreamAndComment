//
//  UIView.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 09/01/25.
//

import Foundation
import UIKit

extension UIView {
    
    func adjustInsetsForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue

        self.frame.origin.y -= keyboardEndFrame?.cgRectValue.height ?? 0
    }

    @objc private func keyboardDidHide(_ notification: Notification) {
        self.frame.origin.y = 0
    }

    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
}
