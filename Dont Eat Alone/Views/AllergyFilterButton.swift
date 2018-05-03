//
//  AllergyFilterButton.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

//@IBDesignable
class AllergyFilterButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable
    var is_selected: Bool = false
    weak var parentVC: MenuVC?
    
    var _allergy_enum = Allergen.None
    @IBInspectable
    var allergy_name = ""
    var allergy_enum: Allergen{
        set (newVal){
            _allergy_enum = newVal
            allergy_name = allergy_enum.rawValue
            fit_to_word_length()
        }
        get{
            return _allergy_enum
        }
    }
    
    func fit_to_word_length() {
        self.sizeToFit()
        let w = self.frame.size.width
        let h = self.frame.size.height
        self.frame.size = CGSize(width: 1.3*w, height: h)
    }
    
    @objc func onPress() {
        if(self.backgroundColor == UIColor.clear) {
            self.backgroundColor = UIColor.deaGrey
            self.setTitleColor(UIColor.deaWhite, for: .normal)
            self.setTitle(allergy_name, for: .normal)
            parentVC?.allergenUpdateData(allergy_enum, s:"On")
            fit_to_word_length()
        }
        else {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.deaGrey, for: .normal)
            self.setTitle(allergy_name, for: .normal)
            parentVC?.allergenUpdateData(allergy_enum, s:"Off")
            fit_to_word_length()
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

    
    
    func setup(){
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.deaGrey.cgColor
        self.layer.cornerRadius = 10
        self.setTitleColor(UIColor.deaGrey, for: .normal)
        self.setTitle(allergy_name, for: .normal)
        fit_to_word_length()
        
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
}
