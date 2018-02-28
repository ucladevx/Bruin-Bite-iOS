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
    
    @nonobjc class var deaAppleGreen: UIColor {
        return UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaSunYellow: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 231.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deaScarlet: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

extension UIFont {
    @nonobjc class var deaHeader: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }
};

extension UIView {
    func addBorderTop(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    func addBorderBottom(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    func addBorderLeft(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    func addBorderRight(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    private func addBorderUtility(x x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}
