//
//  UIButtonExtensions.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/28/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonSignUp: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 26
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.signUpFont
    }
}
