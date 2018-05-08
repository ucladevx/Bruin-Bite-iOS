//
//  LoginViewController.swift
//  Dont Eat Alone
//
//  Created by Samuel J. Lee on 4/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController {

    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var ContinueFBButton: UIButton!
    @IBOutlet var CheckMenuButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        
        SignUpButton.layer.borderWidth = 1
        SignUpButton.backgroundColor = .clear
        SignUpButton.layer.borderColor = UIColor.white.cgColor
        SignUpButton.layer.cornerRadius = 26
        SignUpButton.setTitleColor(UIColor.white, for: .normal)
        SignUpButton.titleLabel?.font = UIFont.signUpFont
        
        ContinueFBButton.layer.borderWidth = 1
        ContinueFBButton.backgroundColor = .clear
        ContinueFBButton.layer.borderColor = UIColor.white.cgColor
        ContinueFBButton.layer.cornerRadius = 26
        ContinueFBButton.setTitleColor(UIColor.white, for: .normal)
        ContinueFBButton.titleLabel?.font = UIFont.continueFbFont
        
        
        CheckMenuButton.layer.borderWidth = 1
        CheckMenuButton.backgroundColor = .clear
        CheckMenuButton.layer.borderColor = UIColor.white.cgColor
        CheckMenuButton.layer.cornerRadius = 26
        CheckMenuButton.setTitleColor(UIColor.white, for: .normal)
        CheckMenuButton.titleLabel?.font = UIFont.signUpFont
        
        SignInButton.backgroundColor = .clear
        SignInButton.setTitleColor(UIColor.white, for: .normal)
        SignInButton.titleLabel?.font = UIFont.signInFont
        // underline: https://medium.com/@minholee_21851/underline-text-in-uibutton-8e79d1018586
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print("Error:::::::\(error)")
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                
                //Test if user already exists
                //false - "RegistrationView"
                //true - "MainView"
                let nextViewID = "RegistrationView"
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: nextViewID)
                self.present(nextViewController, animated:false, completion:nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
