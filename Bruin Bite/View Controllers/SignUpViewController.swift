//
//  SignUpViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import ViewAnimator

class SignUpViewController: UIViewController, SignupDelegate, LoginDelegate, AlertPresentable {

    @IBOutlet var NameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ConfirmPassText: UITextField!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TermsAndCondsTextView: UITextView!
    
    private var TERMS_AND_CONDITIONS_ATTR_STR: NSMutableAttributedString {
        get {
            let attributedString = NSMutableAttributedString(string: "By signing up, you agree to our privacy policy and terms of service.")
            let attributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "Avenir Next-Regular", size: 13.0), size: 13.0), NSAttributedString.Key.foregroundColor: UIColor.white] as [NSAttributedStringKey : Any]
            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(.link, value: "https://tinyurl.com/bruin-bite-pp", range: NSRange(location: 32, length: 14))
            attributedString.addAttribute(.link, value: "https://tinyurl.com/bruin-bite-tos", range: NSRange(location: 51, length: 16))
            return attributedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.hidesWhenStopped = true
        UserManager.shared.signupDelegate = self
        UserManager.shared.loginDelegate = self

        view.backgroundColor = UIColor.twilightBlue

        NameText.font = UIFont.signUpInfoFieldFont
        EmailText.font = UIFont.signUpInfoFieldFont
        NameText.textColor = .white
        EmailText.textColor = .white
        PasswordText.font = UIFont.signUpInfoFieldFont
        ConfirmPassText.font = UIFont.signUpInfoFieldFont

        NameText.becomeFirstResponder()

        TermsAndCondsTextView.attributedText = TERMS_AND_CONDITIONS_ATTR_STR
        TermsAndCondsTextView.linkTextAttributes = [
            NSMutableAttributedString.Key.foregroundColor.rawValue: UIColor.white,
            NSMutableAttributedString.Key.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Clear away "x" button if returning from createProfileView
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

    @IBAction func nextButtonPressed (_ sender: Any?) {
        if(!(EmailText.text?.isEmail() ?? false)) {
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid email", field: EmailText)
            return
        }
        if((PasswordText.text ?? "") != ConfirmPassText.text ) { //I was worried about nil == nil
            Utilities.sharedInstance.displayErrorLabel(text: "Passwords do not match", field: ConfirmPassText)
            return
        }
        //activityIndicator.startAnimating()
        UserManager.shared.createUser(email: EmailText.text ?? "", password: PasswordText.text ?? "", firstName: NameText.text ?? "")
    }

    func didFinishSignup() {
        UserManager.shared.loginUser(email: UserManager.shared.getEmail(), password: PasswordText.text ?? "")
        UserDefaultsManager.shared.setPassword(to: PasswordText.text ?? "")
    }

    func didLogin() {
        //activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "toProfileController", sender: nil)
    }

    func signUpFailed(error: String) {
        //activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }

    func loginFailed(error: String) {
        //activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }
}
