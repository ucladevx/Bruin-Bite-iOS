//
//  AllergensBarScrollView.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 3/11/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import SnapKit

class AllergensBarScrollView: UIScrollView {
    var content = AllergensBarContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.isExclusiveTouch = false
        self.isUserInteractionEnabled = true
        self.delaysContentTouches = false
        self.canCancelContentTouches = true
        self.addSubview(content)
        content.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(self)
            make.size.equalTo(CGSize(width: 735, height: self.frame.height))
        }
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}
