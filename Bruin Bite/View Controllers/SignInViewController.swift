//
//  SignInViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya

class SignInViewController: UIViewController, LoginDelegate, AlertPresentable {
    
    @IBOutlet var SignInText: UILabel!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ForgotPassButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
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
    }
    
    @IBAction func didPressSignIn(_ sender: UIButton) {
        activityIndicator.startAnimating()
        UserManager.shared.loginUser(email: EmailText.text ?? "", password: PasswordText.text ?? "")
    }

    func didLogin() {
        activityIndicator.stopAnimating()
        UserManager.shared.readUser(email: EmailText.text ?? "")
        UserDefaultsManager.shared.setPassword(to: PasswordText.text ?? "")
        self.performSegue(withIdentifier: "ShowMenuVC_2", sender: nil)
    }

    func loginFailed(error: String) {
        activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }
}

