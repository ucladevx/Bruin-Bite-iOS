//
//  TimeView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 2/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

protocol TimeViewTappedDelegate {
    func timeSelected(_ selectedLabelText: String)
}

@IBDesignable class TimeView: UIView {
    var timeLbl = UILabel()
    
    var tapGest: UITapGestureRecognizer?
    var delegate: TimeViewTappedDelegate?
    
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
        timeLbl.font = timeLbl.font.withSize(15)
        timeLbl.textColor = UIColor.white
        timeLbl.textAlignment = .center
        self.addSubview(timeLbl)
    }
    
    func setDelegateAndTap(_ delegate: TimeViewTappedDelegate) {
        self.delegate = delegate
        self.tapGest = UITapGestureRecognizer(target: self, action: #selector(self.timeViewTapped))
        tapGest?.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tapGest!)
    }
    
    @objc
    func timeViewTapped() {
        delegate!.timeSelected(self.timeLbl.text!)
    }
    
}

