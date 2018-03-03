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
        //        color.set()
        //        pathForCircle().fill(
        
        
        
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let width = UIScreen.main.bounds.size.width
        
            if(self.percentage > 0.8) {
                let start_width = 0.8*width
                let percent_filled = (self.percentage - 0.8)*width
                
                ctx.setFillColor(UIColor.deaScarlet.cgColor)
                ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: CGFloat(start_width+percent_filled), height: 10), byRoundingCorners: [], cornerRadii: CGSize(width: 6, height: 6)).cgPath)
                
                
                ctx.fillPath()
                
            }
            if(self.percentage > 0.6) {
                ctx.setFillColor(UIColor.deaYellow.cgColor)
                
                let start_width = 0.6*width
                var percent_filled: CGFloat
                if(self.percentage > 0.8) {
                    percent_filled = 0.2*width
                }
                else {
                    percent_filled = (self.percentage - 0.6)*width
                }
                ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: start_width + percent_filled, height: 10), byRoundingCorners: [], cornerRadii: CGSize(width: 6, height: 6)).cgPath)
                ctx.fillPath()
            }
            
            var percent_filled: CGFloat = 0
            if(self.percentage > 0.6) {
                percent_filled = 1
            }
            else {
                percent_filled = self.percentage/0.6
            }
            ctx.setFillColor(UIColor.deaAppleGreen.cgColor)
            ctx.addPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0.6*width*percent_filled, height: 10), byRoundingCorners: [], cornerRadii: CGSize(width: 6, height: 6)).cgPath)
            //
            
            ctx.closePath()
            ctx.fillPath()
            ctx.restoreGState()
    }
    
    func resizeToZero(){
        self.frame.size.width = 0
    }
    
    func animateBar(){
        self.frame.size.width = UIScreen.main.bounds.size.width
    }
}
