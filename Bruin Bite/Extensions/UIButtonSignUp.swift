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

class SuccessfulPendingSegmentedControl: UISegmentedControl {
    
    private let buttonBar: UIView = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "AvenirNext-Regular", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.darkGray
            ], for: .normal)
        self.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "AvenirNext-DemiBold", size: 18),
            NSAttributedStringKey.foregroundColor: UIColor.twilightBlue
            ], for: .selected)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = CGFloat(1)

        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.twilightBlue
        
        self.addSubview(buttonBar)
        
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(lessThanOrEqualToConstant: 2).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / CGFloat(self.numberOfSegments)).isActive = true
        
        //self.addTarget(self, action: "segmentedControlValueChanged:", for:.valueChanged)
    }
    
    func changeButtonBarPosition() {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.frame.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        }
    }
}
