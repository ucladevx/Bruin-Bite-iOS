//
//  ColoredCircle.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class ColoredCircle: UIView {
    
    var scale: CGFloat = 0.9
    @IBInspectable
    var color: UIColor = .white{
        didSet{
            setNeedsDisplay()
        }
    }
    
    private var circleCenter: CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var circleRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    private func pathForCircle() -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: circleCenter,
            radius: circleRadius,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        )
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForCircle().fill()
        
    }
    
    //    init(frame: CGRect, color: UIColor) {
    //        self.color = color
    //        super.init(frame: frame)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        self.color = .blue
    //        super.init(coder: aDecoder)
    //    }
}

