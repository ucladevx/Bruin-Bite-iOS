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
        if((MajorText.text ?? "") == "") {
            //Invalid Major
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a major", field: MajorText)
            return
        }
        guard let year = Int(YearText.text!) else {
            //Invalid Year
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid year", field: YearText)
            return
        }
        if( year < 0 || year > 5 ) {
            //Invalid Year
            Utilities.sharedInstance.displayErrorLabel(text: "Enter a valid year", field: YearText)
            return
        }
//        MAIN_USER.changeUserInfo(type: "major", info: MajorText.text!)
//        MAIN_USER.changeYear(year: year)
//        // Attempts to create a user, returns false if
//        if(!MAIN_USER.createUser(devid: UserDefaults.standard.object(forKey: "Dev_Token") as? String ?? "")) {
//            print(MAIN_USER.accessUserInfo(type: "error"))
//        }
//
//        if(MAIN_USER.accessUserId() == -1) {
//            return
//        }
        
        //        switch MAIN_USER.accessUserInfo(type: "error") {
        //        case "major":
        //            //Invalid Major
        //            return
        //        case "year":
        //            //Invalid Year
        //            return
        //        case: "bio":
        //            //Invalid Bio
        //            return
        //        default:
        //            //Unknown Invalid
        //            return
        //        }
      
        self.performSegue(withIdentifier: "ShowMenuVC_1", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
