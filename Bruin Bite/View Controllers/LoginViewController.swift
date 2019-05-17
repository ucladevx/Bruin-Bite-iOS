//
//  LoginViewController.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 4/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

// TODO:
/*
 - add in transitions b/w view controllers
 - splash screen transition and length
 - clicking on image to upload image for profile pic
 */

import UIKit

class LoginViewController: UIViewController {
    var isSigningUp: Bool = true
    
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var CheckMenuButton: UIButton!
    @IBOutlet var SignInButton: UIButton!

    // change button and text color when pressed
    @IBAction func SignUpTap(_ sender: Any) {
        if SignUpButton.backgroundColor == .clear {
            SignUpButton.backgroundColor = UIColor.white
            SignUpButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
        
        self.performSegue(withIdentifier: "toSignUpController", sender: sender)
        
    }
    
    // change button and text color when pressed
    @IBAction func CheckMenuTap(_ sender: Any) {
        if CheckMenuButton.backgroundColor == .clear {
            CheckMenuButton.backgroundColor = UIColor.white
            CheckMenuButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
//        let storyBoard = UIStoryboard(name: "Menu", bundle: nil)
//        let menuVC = storyBoard.instantiateViewController(withIdentifier: "menuNavController") as! UINavigationController
//        self.present(menuVC, animated: true, completion: { })
    }
    
    @IBAction func SignInTap(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignInController", sender: sender)
    }
    
//    var attrs = [
//        NSAttributedStringKey.font: UIFont.signInFont.withSize(14.0),
//        NSAttributedStringKey.foregroundColor: UIColor.white,
//        NSAttributedStringKey.underlineStyle: 1
//        ] as [NSAttributedStringKey: Any]
    
    var attrs = [
        NSAttributedStringKey.font: UIFont.signInFont.withSize(16.0),
        NSAttributedStringKey.foregroundColor: UIColor.white
        ] as [NSAttributedStringKey: Any]

    
    var attributedString = NSMutableAttributedString(string:"")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background color
        view.backgroundColor = UIColor.twilightBlue
        
        // set SignInButton font, color, text
        let SignInText = NSMutableAttributedString(string:"Sign In", attributes:attrs)
        attributedString.append(SignInText)
        SignInButton.setAttributedTitle(attributedString, for: .normal)
        SignInButton.backgroundColor = .clear
        SignInButton.setTitleColor(UIColor.white, for: .normal)
        SignInButton.titleLabel?.font = UIFont.signInFont
        SignInButton.layer.borderWidth = 1
        SignInButton.layer.borderColor = UIColor.white.cgColor
        SignInButton.layer.cornerRadius = 26
        SignInButton.setTitleColor(UIColor.white, for: .normal)
        
        // set SignUpButton font, color, text, border
        SignUpButton.layer.borderWidth = 1
        SignUpButton.backgroundColor = .clear
        SignUpButton.layer.borderColor = UIColor.white.cgColor
        SignUpButton.layer.cornerRadius = 26
        SignUpButton.setTitleColor(UIColor.white, for: .normal)
        SignUpButton.titleLabel?.font = UIFont.signUpFont
        
        // set CheckMenuButton font, color, text, border
        CheckMenuButton.layer.borderWidth = 1
        CheckMenuButton.backgroundColor = .clear
        CheckMenuButton.layer.borderColor = UIColor.white.cgColor
        CheckMenuButton.layer.cornerRadius = 26
        CheckMenuButton.setTitleColor(UIColor.white, for: .normal)
        CheckMenuButton.titleLabel?.font = UIFont.signUpFont
        
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SignUpButton.backgroundColor = .clear
        SignUpButton.setTitleColor(UIColor.white, for: .normal)
        CheckMenuButton.backgroundColor = .clear
        CheckMenuButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUpController" {
            // Pass data to SignUpViewController
        }
        if segue.identifier == "toSignInController" {
            // Pass data to SignInViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

