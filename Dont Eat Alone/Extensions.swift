//
//  Extensions.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
// Sample color palette

extension UIColor {
    @nonobjc class var deaYellow: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 207.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaLightOrange: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 189.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaPeach: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 103.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaGrey: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaWhite: UIColor {
        return UIColor(white: 244.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

extension UIFont {
    @nonobjc class var deaHeader: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }
};
