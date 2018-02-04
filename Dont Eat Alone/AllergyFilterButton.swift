//
//  AllergyFilterButton.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
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
    @IBInspectable
    var allergy_name: String = ""
    
    @objc func onPress() {
        if(self.backgroundColor == UIColor.clear) {
            self.backgroundColor = UIColor.darkGray
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitle("Vegan", for: .normal)
        }
        else {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.darkGray, for: .normal)
            self.setTitle("Vegan", for: .normal)
        }
    }
    

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
        self.setTitle("Vegan", for: .normal)
        self.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: Code for our button
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }

}
