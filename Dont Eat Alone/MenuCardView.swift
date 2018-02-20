//
//  MenuCardView.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class MenuCardView: UIView {
    
    @IBOutlet var menuCardView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    
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
        Bundle.main.loadNibNamed("MenuCardView", owner: self, options: nil)
        addSubview(menuCardView)
        let screenWidth = self.bounds.size.width
        print(0.8*screenWidth)
        menuCardView.frame = CGRect(x: (screenWidth/2) - (0.8*screenWidth/2), y: 0, width: 0.8*screenWidth, height: 0.8*screenWidth)
        menuCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        menuCardView.backgroundColor = .gray
        menuCardView.layer.cornerRadius = 8
        
        let convert_bar_bounds = menuCardView.convert(activityLevelBar.frame, from: menuCardView)
        
        let bar_height = activityLevelBar.frame.height
       
        activityLevelBar.frame = CGRect(x: activityLevelBar.bounds.origin.x-10, y: activityLevelBar.bounds.origin.y-15, width: menuCardView.bounds.width, height: bar_height)
        print(activityLevelBar.frame.width)
        print(menuCardView.bounds.width)
        menuCardView.clipsToBounds = true
        
    }
}


/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */
