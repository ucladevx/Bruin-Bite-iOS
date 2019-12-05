//
//  SignInViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya
import SafariServices

class SignInViewController: UIViewController, LoginDelegate, AlertPresentable {

    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ForgotPassButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholderText()
        //activityIndicator.hidesWhenStopped = true
        UserManager.shared.loginDelegate = self

        view.backgroundColor = UIColor.twilightBlue
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
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
    }
    
    @IBAction func didPressSignIn(_ sender: UIButton) {
        //activityIndicator.startAnimating()
        UserManager.shared.loginUser(email: EmailText.text ?? "", password: PasswordText.text ?? "")
    }
    
    @IBAction func didPressForgotPassword(_ sender: UIButton) {
        guard let url = URL(string: "https://api.bruin-bite.com/password_reset") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    

    func didLogin() {
        //activityIndicator.stopAnimating()
        UserManager.shared.readUser(email: EmailText.text ?? "")
        UserDefaultsManager.shared.setPassword(to: PasswordText.text ?? "")
        self.performSegue(withIdentifier: "ShowMainViewFromLogin", sender: nil)
    }

    func loginFailed(error: String) {
        //activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }
    func setPlaceholderText()
    {
        let placeholderText = ["Email", "Password"]
        var results = [NSMutableAttributedString]()
        
        for i in 0...1
        {
            let Name  = placeholderText[i] // PlaceHolderText
            let myMutableStringTitle = NSMutableAttributedString(string:Name, attributes: [:]) // Font
            myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0), range:NSRange(location:0,length:Name.characters.count))
            results.append(myMutableStringTitle)
        }
        EmailText.attributedPlaceholder = results[0]
        PasswordText.attributedPlaceholder = results[1]
    }
}
