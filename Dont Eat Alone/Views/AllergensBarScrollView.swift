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
    let label = UILabel()
    var vegetarian = AllergyFilterButton()
    //    self.addSubview(vegetarian)
    
    func setup(){
        vegetarian.allergy_name = "Vegetarian"
        self.addSubview(vegetarian)
        vegetarian.setup()
        vegetarian.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 0, 0))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

