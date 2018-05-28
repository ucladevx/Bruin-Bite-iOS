//
//  AllergensBarContentView.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import SnapKit

class AllergensBarContentView: UIView {
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
    var treenuts = AllergyFilterButton()
    var wheat = AllergyFilterButton()
    var soy = AllergyFilterButton()
    var dairy = AllergyFilterButton()
    var eggs = AllergyFilterButton()
    var shellfish = AllergyFilterButton()
    var fish = AllergyFilterButton()
    
    func setup(){
        self.isUserInteractionEnabled = true
        vegetarian.parentVC = self.parentVC
        vegetarian.allergy_enum = Allergen.Vegetarian
        vegetarian.setup()
        self.addSubview(vegetarian)
        vegetarian.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
            make.size.equalTo(CGSize(width: 113.1, height: 34))
        }
        
        vegan.parentVC = self.parentVC
        vegan.allergy_enum = Allergen.Vegan
        self.addSubview(vegan)
        vegan.setup()
        vegan.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(vegetarian.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 66.3, height: 34))
        }
        
        peanuts.parentVC = self.parentVC
        peanuts.allergy_enum = Allergen.ContainsPeanuts
        self.addSubview(peanuts)
        peanuts.setup()
        peanuts.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(vegan.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 85.8, height: 34))
        }
        
        treenuts.parentVC = self.parentVC
        treenuts.allergy_enum = Allergen.ContainsTreeNuts
        self.addSubview(treenuts)
        treenuts.setup()
        treenuts.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(peanuts.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 96.2, height: 34))
        }
        
        wheat.parentVC = self.parentVC
        wheat.allergy_enum = Allergen.ContainsWheat
        self.addSubview(wheat)
        wheat.setup()
        wheat.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(treenuts.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 68.9, height: 34))
        }
        
        soy.parentVC = self.parentVC
        soy.allergy_enum = Allergen.ContainsSoy
        self.addSubview(soy)
        soy.setup()
        soy.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(wheat.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 40.3, height: 34))
        }
        
        dairy.parentVC = self.parentVC
        dairy.allergy_enum = Allergen.ContainsDairy
        self.addSubview(dairy)
        dairy.setup()
        dairy.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(soy.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 54.6, height: 34))
        }
        
        shellfish.parentVC = self.parentVC
        shellfish.allergy_enum = Allergen.ContainsShellfish
        self.addSubview(shellfish)
        shellfish.setup()
        shellfish.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(dairy.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 89.7, height: 34))
        }
        
        fish.parentVC = self.parentVC
        fish.allergy_enum = Allergen.ContainsFish
        self.addSubview(fish)
        fish.setup()
        fish.snp.makeConstraints{(make) -> Void in
            make.top.bottom.equalTo(vegetarian)
            make.left.equalTo(shellfish.snp.rightMargin).offset(15)
            make.size.equalTo(CGSize(width: 44.2, height: 34))
        }
    }
}
