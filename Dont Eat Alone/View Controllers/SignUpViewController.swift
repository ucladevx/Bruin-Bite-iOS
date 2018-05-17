//
//  SignUpViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var SignUpText: UILabel!
    @IBOutlet var NameText: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordText: UITextField!
    @IBOutlet var ConfirmPassText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        SignUpText.font = UIFont.signUpTextFont.withSize(20)
        
        NameText.font = UIFont.signUpInfoFieldFont
        EmailText.font = UIFont.signUpInfoFieldFont
        NameText.textColor = .white
        EmailText.textColor = .white
        PasswordText.font = UIFont.signUpInfoFieldFont
        ConfirmPassText.font = UIFont.signUpInfoFieldFont
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
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
