//
//  WeekView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/7/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
@IBDesignable

protocol WeekViewTappedDelegate {
    func daySelected(_ selectedLabelText: String)
}

class WeekView: UIView {
    @IBOutlet var dateLbl: UILabel!
    
    var tapGesture: UITapGestureRecognizer?
    var delegate: WeekViewTappedDelegate?
    
    func setDelegateAndTap(_ delegate: WeekViewTappedDelegate) {
        self.delegate = delegate
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.weekViewTapped))
        tapGesture?.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tapGesture!)
    }
    
    @objc
    func weekViewTapped() {
        delegate!.daySelected(self.dateLbl.text!)
    }

}
