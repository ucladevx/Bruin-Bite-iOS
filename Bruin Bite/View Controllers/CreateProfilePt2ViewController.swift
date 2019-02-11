//
//  CreateProfilePt2ViewController.swift
//  Dont Eat Alone
//
//  Created by Cynthia Zhou on 5/20/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfilePt2ViewController: UIViewController, UpdateDelegate, AlertPresentable {

    @IBOutlet var CreateButton: UIButton!
    @IBOutlet var YearText: UITextField!
    @IBOutlet var MajorText: UITextField!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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

    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.hidesWhenStopped = true
        UserManager.shared.updateDelegate = self

        view.backgroundColor = UIColor.twilightBlue
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
        
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let xButton = UIBarButtonItem(image: UIImage(named: "x"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popToRoot(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = xButton
    }
    
    @objc
    func popToRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func didUpdateUser() {
        //activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "ShowMainViewFromCreate", sender: nil)
    }

    func updateFailed(error: String) {
        //activityIndicator.stopAnimating()
        presentAlert(alert: error)
    }

    @IBAction func didPressCreate(_ sender: UIButton) {
        if((MajorText.text ?? "") == "") {
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a major", field: MajorText)
            return
        }
        guard let year = Int(YearText.text!) else {
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid year", field: YearText)
            return
        }
        if year != 1, year != 2, year != 3, year != 4, year != 5 {
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid year", field: YearText)
            return
        }
        //activityIndicator.startAnimating()
        UserManager.shared.signupUpdate(email: UserManager.shared.getEmail(),
                                        password: UserDefaultsManager.shared.getPassword(),
                                        first_name: UserManager.shared.getFirstName(), last_name: UserManager.shared.getLastName(),
                                        major: MajorText.text ?? "",
                                        minor: UserManager.shared.getMinor(),
                                        year: Int(YearText.text ?? "") ?? 0,
                                        self_bio: UserManager.shared.getBio())
    }
}
