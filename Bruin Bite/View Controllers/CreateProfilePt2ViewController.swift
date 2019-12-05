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
    @IBOutlet weak var year: UISegmentedControl!
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
        setPlaceholderText()
        UserManager.shared.updateDelegate = self

        view.backgroundColor = UIColor.twilightBlue
        MajorText.font = UIFont.signUpInfoFieldFont
        MajorText.textColor = .white
        CreateButton.setTitleColor(UIColor.white, for: .normal)
        CreateButton.titleLabel?.font = UIFont.signUpInfoFieldFont
        CreateButton.layer.borderWidth = 1
        CreateButton.layer.borderColor = UIColor.white.cgColor
        CreateButton.layer.cornerRadius = 26
        
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
        // Removed optional binding here because index is never nil
        let chosenYear = Int(year.selectedSegmentIndex + 1)
        if chosenYear != 1, chosenYear != 2, chosenYear != 3, chosenYear != 4, chosenYear != 5 {
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid year", field: year)
            return
        }
        //activityIndicator.startAnimating()
        UserManager.shared.signupUpdate(email: UserManager.shared.getEmail(),
                                        first_name: UserManager.shared.getFirstName(), last_name: UserManager.shared.getLastName(),
                                        major: MajorText.text ?? "",
                                        minor: UserManager.shared.getMinor(),
                                        year: chosenYear,
                                        self_bio: UserManager.shared.getBio())
    }
    func setPlaceholderText()
    {
            let Name  = "Major" // PlaceHolderText
            let myMutableStringTitle = NSMutableAttributedString(string:Name, attributes: [:]) // Font
            myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0), range:NSRange(location:0,length:Name.characters.count))

        MajorText.attributedPlaceholder = myMutableStringTitle

    }
}
