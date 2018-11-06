//
//  SignUpViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import ViewAnimator

class SignUpViewController: UIViewController {
    
    @IBOutlet var NameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ConfirmPassText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        
        NameText.font = UIFont.signUpInfoFieldFont
        EmailText.font = UIFont.signUpInfoFieldFont
        NameText.textColor = .white
        EmailText.textColor = .white
        PasswordText.font = UIFont.signUpInfoFieldFont
        ConfirmPassText.font = UIFont.signUpInfoFieldFont
        
        NameText.becomeFirstResponder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Clear away "x" button if returning from createProfileView
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfileController" {
            // Pass data to CreateProfileViewController
        }
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
        
        self.performSegue(withIdentifier: "toProfileController", sender: sender)
    }
}

