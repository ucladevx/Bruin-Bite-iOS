//
//  SignUpViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController, SignupDelegate, LoginDelegate {
    
    @IBOutlet var SignUpText: UILabel!
    @IBOutlet var NameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ConfirmPassText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        UserManager.shared.signupDelegate = self
        UserManager.shared.loginDelegate = self
        
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
        activityIndicator.startAnimating()
        UserManager.shared.createUser(email: EmailText.text ?? "", password: PasswordText.text ?? "", firstName: NameText.text ?? "")
    }

    func didFinishSignup() {
        UserManager.shared.loginUser(email: UserManager.shared.getEmail(), password: PasswordText.text ?? "")
        UserDefaultsManager.shared.setPassword(to: PasswordText.text ?? "")
    }

    func didLogin() {
        activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "DoneWithSignUp", sender: nil)
    }
}

