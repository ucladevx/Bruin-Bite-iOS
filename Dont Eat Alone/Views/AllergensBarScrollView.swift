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
    weak var _parentVC: MenuVC?
    weak var parentVC: MenuVC?{
        set(newVal){
            _parentVC = newVal
            setup()
        }
        get{
            return _parentVC
        }
    }
    var vegetarian = AllergyFilterButton()
    var vegan = AllergyFilterButton()
    var peanuts = AllergyFilterButton()
    
    func setup(){
        vegetarian.parentVC = self.parentVC
        vegetarian.allergy_enum = Allergen.Vegetarian
        vegetarian.setup()
        self.addSubview(vegetarian)
        vegetarian.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 0, 0))
        }
        vegan.parentVC = self.parentVC
        vegan.allergy_enum = Allergen.Vegan
        self.addSubview(vegan)
        vegan.setup()
        vegan.snp.makeConstraints{(make) -> Void in
           make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(vegetarian).offset(115)
            make.right.equalTo(vegetarian).offset(135)
        }
        peanuts.parentVC = self.parentVC
        peanuts.allergy_enum = Allergen.ContainsPeanuts
        self.addSubview(peanuts)
        peanuts.setup()
        peanuts.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegan)
            make.left.equalTo(vegan).offset(75)
            make.right.equalTo(vegan).offset(95)
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

