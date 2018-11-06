//
//  SignInViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya

class SignInViewController: UIViewController {
    
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ForgotPassButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        MAIN_USER.changeUserInfo(type: "email", info: EmailText.text!)
        MAIN_USER.changeUserInfo(type: "password", info: PasswordText.text!)
        MAIN_USER.loginUser()
        if(UserDefaults.standard.object(forKey: "accessToken") == nil) {
            return
        }
        if(MAIN_USER.getToken() != nil) {
            MAIN_USER.readUser()
            MAIN_USER.updateUser(dev_id: UserDefaults.standard.object(forKey: "Dev_Token") as? String ?? "")
            self.performSegue(withIdentifier: "ShowMenuVC_2", sender: nil)
        } else {
            return
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

