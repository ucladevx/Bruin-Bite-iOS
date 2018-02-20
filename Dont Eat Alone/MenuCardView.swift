//
//  MenuCardView.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuCardView: UIView {
    
    @IBOutlet var menuCardView: UIView!
    @IBOutlet weak var label: UILabel!
    
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
        menuCardView.frame = self.bounds
        menuCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        menuCardView.backgroundColor = .green
        label.text = "This works"
    }
}


/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */
