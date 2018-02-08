//
//  WeekView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/7/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
@IBDesignable
class WeekView: UIView {
    @IBOutlet var dateLbl: UILabel!
    
    var tapGesture: UITapGestureRecognizer?
    var delegate: DayViewTappedDelegate?
    
    func setDelegateAndTap(_ delegate: DayViewTappedDelegate) {
        self.delegate = delegate
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dayViewTapped))
        tapGesture?.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tapGesture!)
    }
    
    @objc
    func dayViewTapped() {
        delegate!.daySelected(self.dateLbl.text!)
    }

}
