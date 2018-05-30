//
//  AllergyFilterButton.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class AllergyFilterButton: UIButton {
    
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
        }
        get{
            return _allergy_enum
        }
    }
    
    @objc func onPress() {
        if(self.backgroundColor == UIColor.clear) {
            self.backgroundColor = UIColor.deaGrey
            self.setTitleColor(UIColor.deaWhite, for: .normal)
            self.setTitle(allergy_name, for: .normal)
            parentVC?.allergenUpdateData(allergy_enum, status: true)
            self.sizeToFit()
        }
        else {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.deaGrey, for: .normal)
            self.setTitle(allergy_name, for: .normal)
            parentVC?.allergenUpdateData(allergy_enum, status: false)
            self.sizeToFit()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let amendedSize:CGSize = super.sizeThatFits(size)
        let newSize:CGSize = CGSize.init(width: 1.3*amendedSize.width, height: amendedSize.height)
        return newSize;
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
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        self.sizeToFit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
}
