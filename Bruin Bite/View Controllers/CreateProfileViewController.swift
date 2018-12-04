//
//  CreateProfileViewController.swift
//  Dont Eat Alone
//  Created by Kameron Carr on 4/29/18.
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UpdateDelegate, AlertPresentable {
    
    @IBOutlet var CreateProfileText: UILabel!
    @IBOutlet var BioText: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var BioTextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        UserManager.shared.updateDelegate = self
        
        view.backgroundColor = UIColor.twilightBlue
        CreateProfileText.font = UIFont.signUpTextFont
        BioTextBox.layer.borderWidth = 1
        BioTextBox.layer.borderColor = UIColor.white.cgColor
        BioTextBox.layer.cornerRadius = 11
        
        BioText.font = UIFont.bioFont
        BioTextBox.becomeFirstResponder()
    }
    
    @IBAction func nextButtonPressed (_ sender: Any?) {
        activityIndicator.startAnimating()
        UserManager.shared.signupUpdate(email: UserManager.shared.getEmail(), password: UserDefaultsManager.shared.getPassword(), first_name: UserManager.shared.getFirstName(), last_name: UserManager.shared.getLastName(), major: UserManager.shared.getMajor(), minor: UserManager.shared.getMinor(), year: UserManager.shared.getYear(), self_bio: BioTextBox.text ?? "")
    }

    func didUpdateUser() {
        self.performSegue(withIdentifier: "EndPt1", sender: nil)
        activityIndicator.stopAnimating()
    }

    func updateFailed(error: String) {
        activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }
}

