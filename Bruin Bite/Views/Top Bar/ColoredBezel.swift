//
//  ColoredBezel.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class ColoredBezel: UIView {
    
    @IBInspectable
    var color: UIColor = .white{
        didSet{
            setNeedsDisplay()
        }
    }
    
    private func pathForCircle() -> UIBezierPath {
        let path = UIBezierPath(roundedRect: CGRect(x: 5, y: 5, width: 77.5, height: 30), byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10))
        return path
    }
    
    override func draw(_ rect: CGRect) {
        layer.borderColor = UIColor.clear.cgColor
        color.set()
        pathForCircle().fill()
    }
}
