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
 - fb button color change when cancelling
 - clicking on image to upload image for profile pic
 */

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {
    var isSigningUp: Bool = true
    
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var ContinueFBButton: UIButton!
    @IBOutlet var CheckMenuButton: UIButton!
    @IBOutlet var SignInButton: UIButton!

    // change button and text color when pressed
    @IBAction func SignUpTap(_ sender: Any) {
        if SignUpButton.backgroundColor == .clear {
            SignUpButton.backgroundColor = UIColor.white
            SignUpButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
        else {
            SignUpButton.backgroundColor = .clear
            SignUpButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    // change button and text color when pressed
    @IBAction func ContinueFBTap(_ sender: Any) {
        if ContinueFBButton.backgroundColor == .clear {
            ContinueFBButton.backgroundColor = UIColor.white
            ContinueFBButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
            
        else {
            ContinueFBButton.backgroundColor = .clear
            ContinueFBButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        // FB authentification
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print("Error:::::::\(error)")
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                //if user exists and login suceeds
                //self.performSegue(withIdentifier: "CheckMenusSegue", sender: sender)
                //else
                self.performSegue(withIdentifier: "CreateProfileSegue", sender: sender)
            }
        }
    }
    
    // change button and text color when pressed
    @IBAction func CheckMenuTap(_ sender: Any) {
        if CheckMenuButton.backgroundColor == .clear {
            CheckMenuButton.backgroundColor = UIColor.white
            CheckMenuButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
        else {
            CheckMenuButton.backgroundColor = .clear
            CheckMenuButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    var attrs = [
        NSAttributedStringKey.font: UIFont.signInFont.withSize(14.0),
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.underlineStyle: 1
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
        
        // set SignUpButton font, color, text, border
        SignUpButton.layer.borderWidth = 1
        SignUpButton.backgroundColor = .clear
        SignUpButton.layer.borderColor = UIColor.white.cgColor
        SignUpButton.layer.cornerRadius = 26
        SignUpButton.setTitleColor(UIColor.white, for: .normal)
        SignUpButton.titleLabel?.font = UIFont.signUpFont
        
        // set ContinueFBButton font, color, text, border
        ContinueFBButton.layer.borderWidth = 1
        ContinueFBButton.backgroundColor = .clear
        ContinueFBButton.layer.borderColor = UIColor.white.cgColor
        ContinueFBButton.layer.cornerRadius = 26
        ContinueFBButton.setTitleColor(UIColor.white, for: .normal)
        ContinueFBButton.titleLabel?.font = UIFont.continueFbFont
        
        // set CheckMenuButton font, color, text, border
        CheckMenuButton.layer.borderWidth = 1
        CheckMenuButton.backgroundColor = .clear
        CheckMenuButton.layer.borderColor = UIColor.white.cgColor
        CheckMenuButton.layer.cornerRadius = 26
        CheckMenuButton.setTitleColor(UIColor.white, for: .normal)
        CheckMenuButton.titleLabel?.font = UIFont.signUpFont
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

