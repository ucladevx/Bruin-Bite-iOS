//
//  WeekView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/7/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

protocol WeekViewTappedDelegate {
    func daySelected(_ selectedLabelText: String)
}

@IBDesignable class WeekView: UIView {
    var dateLbl = UILabel()
    var weekLbl = UILabel()
    
    var tapGesture: UITapGestureRecognizer?
    var delegate: WeekViewTappedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        weekLbl.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        weekLbl.textAlignment = .center
        self.addSubview(weekLbl)
        dateLbl.frame = CGRect(x: 0, y: 40, width: 30, height: 30)
        dateLbl.textAlignment = .center
        self.addSubview(dateLbl)
    }
    
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
