//
//  UIViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/9/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

// Tap to dismiss keyboard can be used by including the following code in viewDidLoad() of UIViewControllers that require this functionality
// self.hideKeyboardWhenTappedAround()
