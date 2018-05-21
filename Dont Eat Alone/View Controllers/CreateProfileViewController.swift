//
//  CreateProfileViewController.swift
//  Dont Eat Alone
//  Created by Kameron Carr on 4/29/18.
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    
    @IBOutlet var CreateProfileText: UILabel!
    @IBOutlet var BioText: UILabel!
    
    @IBOutlet var BioTextBox: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        CreateProfileText.font = UIFont.signUpTextFont
        BioTextBox.layer.borderWidth = 1
        BioTextBox.layer.borderColor = UIColor.white.cgColor
        BioTextBox.layer.cornerRadius = 11
        
        BioText.font = UIFont.bioFont
        BioTextBox.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

