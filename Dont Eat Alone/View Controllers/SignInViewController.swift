//
//  SignInViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/16/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var SignInText: UILabel!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ForgotPassButton: UIButton!
    @IBOutlet var SignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        SignInText.font = UIFont.signUpTextFont.withSize(20)
        EmailText.font = UIFont.signUpInfoFieldFont
        PasswordText.font = UIFont.signUpInfoFieldFont
        EmailText.textColor = .white
        PasswordText.textColor = .white
        // ForgotPassButton.titleLabel?.font = UIFont.forgotPassFont
        SignInButton.setTitleColor(UIColor.white, for: .normal)
        SignInButton.titleLabel?.font = UIFont.signUpInfoFieldFont
        
        SignInButton.layer.borderWidth = 1
        SignInButton.layer.borderColor = UIColor.white.cgColor
        SignInButton.layer.cornerRadius = 26
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
