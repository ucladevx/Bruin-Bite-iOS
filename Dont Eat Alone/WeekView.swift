//
//  WeekView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/7/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

protocol WeekViewTappedDelegate {
    func daySelected(_ selectedLabelText: String, dayLabel: String)
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
        self.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        weekLbl.font = UIFont.boldSystemFont(ofSize: 15)
        dateLbl.font = dateLbl.font.withSize(15)
        dateLbl.textColor = UIColor.white
        weekLbl.textColor = UIColor.white
        self.addSubview(weekLbl)
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
        delegate!.daySelected(self.dateLbl.text!, dayLabel: self.weekLbl.text!)
    }

}
