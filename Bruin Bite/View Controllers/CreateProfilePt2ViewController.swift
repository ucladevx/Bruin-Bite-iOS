//
//  CreateProfilePt2ViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfilePt2ViewController: UIViewController, UpdateDelegate {
    
    @IBOutlet var CreateButton: UIButton!
    @IBOutlet var CreateProfileText: UILabel!
    @IBOutlet var YearText: UITextField!
    @IBOutlet var MajorText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        if((MajorText.text ?? "") == "") {
            //Invalid Major
            return
        }
        guard let year = Int(YearText.text!) else {
            //Invalid Year
            return
        }
        if( year < 0 || year > 5 ) {
            //Invalid Year
            return
        }
        activityIndicator.startAnimating()
        UserManager.shared.signupUpdate(email: UserManager.shared.getEmail(),
                                        password: UserDefaultsManager.shared.getPassword(),
                                        first_name: UserManager.shared.getFirstName(), last_name: UserManager.shared.getLastName(),
                                        major: MajorText.text ?? "",
                                        minor: UserManager.shared.getMinor(),
                                        year: Int(YearText.text ?? "") ?? 0,
                                        self_bio: UserManager.shared.getBio())
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        UserManager.shared.updateDelegate = self
        
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

    func didUpdateUser() {
        activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "ShowMenuVC_1", sender: nil)
    }
    
}
