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
    
    @IBAction func nextButtonPressed (_ sender: Any?) {
        if(NameText.text ?? "" == "") {
            //Invalid Name
            return
        }
        if(!(EmailText.text?.isEmail() ?? false)) {
            //Invalid Email
            return
        }
        if((PasswordText.text?.count ?? 0) < 8) {
            //Invalid Password
             return
        }
        if((PasswordText.text ?? "") != ConfirmPassText.text ) { //I was worried about nil == nil
            //Passwords don't match
            return
        }
        
        MAIN_USER.changeUserInfo(type: "first", info: NameText.text!)
        MAIN_USER.changeUserInfo(type: "email", info: EmailText.text!)
        MAIN_USER.changeUserInfo(type: "password", info: PasswordText.text!)
        
        /* Waiting for Sam
        let result = MAIN_USER.createUser()
        if(result == "username") {
            return
        }
        else if(result == "password") {
            return
        }
        */
        
        self.performSegue(withIdentifier: "DoneWithSignUp", sender: sender)
    }
}

