//
//  ActivityLevelBar.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class ActivityLevelBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var width: CGFloat = UIScreen.main.bounds.width
    @IBInspectable
    var percentage: CGFloat = 0.5
    
    @IBInspectable
    var color: UIColor = .blue{
        didSet{
            setNeedsDisplay()
        }
    }
    
//    private var circleCenter: CGPoint{
//        return CGPoint(x: bounds.midX, y: bounds.midY)
//    }
//
//    private var circleRadius: CGFloat{
//        return min(bounds.size.width, bounds.size.height)/2 * scale
//    }
//
//    private func pathForCircle() -> UIBezierPath {
//        let path = UIBezierPath(
//            arcCenter: circleCenter,
//            radius: circleRadius,
//            startAngle: 0,
//            endAngle: CGFloat.pi * 2,
//            clockwise: true
//        )
//        return path
//    }
    
    override func draw(_ rect: CGRect) {
//        color.set()
//        pathForCircle().fill()
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        if(self.percentage > 0.8) {
            let start_width = 0.8*self.width
            let percent_filled = ((self.percentage - 0.8)/0.2)*0.2*self.width
            ctx.setFillColor(UIColor.red.cgColor)
            ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: start_width+percent_filled, height: 10), cornerRadius: 6.0).cgPath)
            ctx.fillPath()
        
        }
        if(self.percentage > 0.6) {
            ctx.setFillColor(UIColor.yellow.cgColor)
            
            let start_width = 0.6*self.width
            let percent_filled = ((self.percentage - 0.6)/0.2)*0.2*self.width
            ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: start_width + percent_filled, height: 10), cornerRadius: 6.0).cgPath)
            ctx.fillPath()
        }
        

        var percent_filled: CGFloat = 0
        if(self.percentage > 0.6) {
            percent_filled = 1
        }
        else {
            percent_filled = self.percentage/0.6
        }
        ctx.setFillColor(UIColor.green.cgColor)
        ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 0.6*self.width*percent_filled, height: 10), cornerRadius: 6.0).cgPath)

//
        
        ctx.closePath()
        ctx.fillPath()
        ctx.restoreGState()
        
    }

}
