//
//  ActivityLevelBar.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/27/18.
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
    
    //for using custom view in code
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    //for using custom view in Interface Builder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
    }
    
    @IBInspectable
    var percentage: CGFloat = 0.5
    
    override func draw(_ rect: CGRect) {
        
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        let width = UIScreen.main.bounds.size.width
        
        if(self.percentage > 0.8) {
            ctx.setFillColor(UIColor.deaScarlet.cgColor)
        }
        else if(self.percentage > 0.6) {
            ctx.setFillColor(UIColor.deaYellow.cgColor)
        }
        else{
            ctx.setFillColor(UIColor.deaAppleGreen.cgColor)
        }
        ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width*percentage, height: 10), byRoundingCorners: [], cornerRadii: CGSize(width: 6, height: 6)).cgPath)
        
        ctx.closePath()
        ctx.fillPath()
        ctx.restoreGState()
    }
    
    func resizeToZero(){
        self.frame.size.width = 0
    }
    
    func animateBar(){
        self.frame.size.width = UIScreen.main.bounds.size.width
        self.setNeedsDisplay()
    }
}

