//
//  Utilities.swift
//  Bruin Bite
//
//  Created by Clifford Yin on 11/5/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

class Utilities: NSObject {
    
    static let sharedInstance = Utilities()
    
    // Use this to display error labels above input fields
    func displayErrorLabel(text: String, field: UIView) {
        let errorLabel = UILabel(frame: CGRect(x: field.frame.minX, y: field.frame.minY - field.frame.height, width: field.frame.width, height: field.frame.height))
        errorLabel.text = text
        errorLabel.textColor = .red
        field.superview?.addSubview(errorLabel)
        let alertAnimation = AnimationType.from(direction: .bottom, offset: field.frame.height)
        errorLabel.animate(animations: [alertAnimation], reversed: false, initialAlpha: 1.0, finalAlpha: 1.0, delay: 0.0, duration: 1.0, options: .curveEaseOut, completion: {
            let fadeAnimation = AnimationType.from(direction: .bottom, offset: 0)
            errorLabel.animate(animations: [fadeAnimation], reversed: false, initialAlpha: 1.0, finalAlpha: 0.0, delay: 0.0, duration: 0.5, options: .curveLinear, completion: {
                errorLabel.removeFromSuperview()
            })
        })
    }
    
    func formatNavigation(controller: UINavigationController) {
        controller.navigationBar.barTintColor = UIColor(red: 7/255, green: 74/255, blue: 119/255, alpha: 1.0)
        controller.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20.0)!]
        controller.navigationBar.tintColor = .white
        let backItem = UIBarButtonItem(image: UIImage(named: "PrevArrow"), style: .plain, target: self, action: nil)
        controller.navigationBar.backIndicatorImage = UIImage(named: "ClearBackButton")
        controller.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ClearBackButton")
        controller.navigationBar.topItem?.backBarButtonItem = backItem
        controller.navigationBar.shadowImage = UIImage()
        
    }
    
}
