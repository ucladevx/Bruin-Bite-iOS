//
//  SignUpViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var SignUpText: UILabel!
    @IBOutlet var NameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ConfirmPassText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        SignUpText.font = UIFont.signUpTextFont.withSize(20)
        
        NameText.font = UIFont.signUpInfoFieldFont
        EmailText.font = UIFont.signUpInfoFieldFont
        NameText.textColor = .white
        EmailText.textColor = .white
        PasswordText.font = UIFont.signUpInfoFieldFont
        ConfirmPassText.font = UIFont.signUpInfoFieldFont
        
        NameText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }

}