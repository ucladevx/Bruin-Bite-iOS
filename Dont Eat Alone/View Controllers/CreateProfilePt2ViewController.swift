//
//  CreateProfilePt2ViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfilePt2ViewController: UIViewController {
    
    @IBOutlet var CreateButton: UIButton!
    @IBOutlet var CreateProfileText: UILabel!
    @IBOutlet var YearText: UITextField!
    @IBOutlet var MajorText: UITextField!
    
    @IBAction func CreateTap(_ sender: Any) {
        if CreateButton.backgroundColor == .clear {
            CreateButton.backgroundColor = UIColor.white
            CreateButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        }
        else {
            CreateButton.backgroundColor = .clear
            CreateButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func didPressCreate(_ sender: UIButton) {
        // TODO: Add code to verify sign up.
        MAIN_USER.changeUserInfo(type: "major", info: MajorText.text!)
        if let year = Int(YearText.text!) {
            MAIN_USER.changeYear(year: year)
        }
        //MAIN_USER.createUser()
        self.performSegue(withIdentifier: "ShowMenuVC_1", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        CreateProfileText.font = UIFont.signUpTextFont
        YearText.font = UIFont.signUpInfoFieldFont
        MajorText.font = UIFont.signUpInfoFieldFont
        YearText.textColor = .white
        MajorText.textColor = .white
        CreateButton.setTitleColor(UIColor.white, for: .normal)
        CreateButton.titleLabel?.font = UIFont.signUpInfoFieldFont
        
        YearText.becomeFirstResponder()
        
        CreateButton.layer.borderWidth = 1
        CreateButton.layer.borderColor = UIColor.white.cgColor
        CreateButton.layer.cornerRadius = 26
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

