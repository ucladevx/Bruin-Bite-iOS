//
//  SignInViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya

class SignInViewController: UIViewController, LoginDelegate {
    
    @IBOutlet var SignInText: UILabel!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ForgotPassButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserManager.shared.loginDelegate = self
        
        view.backgroundColor = UIColor.twilightBlue
        SignInText.font = UIFont.signUpTextFont.withSize(20)
        EmailText.font = UIFont.signUpInfoFieldFont
        PasswordText.font = UIFont.signUpInfoFieldFont
        EmailText.textColor = .white
        PasswordText.textColor = .white
        SignInButton.setTitleColor(UIColor.white, for: .normal)
        SignInButton.titleLabel?.font = UIFont.signUpInfoFieldFont
        
        SignInButton.layer.borderWidth = 1
        SignInButton.layer.borderColor = UIColor.white.cgColor
        SignInButton.layer.cornerRadius = 26
        
        EmailText.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func didPressSignIn(_ sender: UIButton) {
        if(!(EmailText.text?.isEmail() ?? false)) {
            //Invalid Email
            return
        }
        if((PasswordText.text?.count ?? 0) < 8) {
            //Invalid Password
            return
        }
        UserManager.shared.loginUser()
    }

    func didLogin() {
        self.performSegue(withIdentifier: "ShowMenuVC_2", sender: nil)
    }
}

