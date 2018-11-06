//
//  CreateProfileViewController.swift
//  Dont Eat Alone
//  Created by Kameron Carr on 4/29/18.
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    
    @IBOutlet var BioText: UILabel!
    
    @IBOutlet var BioTextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        BioTextBox.layer.borderWidth = 1
        BioTextBox.layer.borderColor = UIColor.white.cgColor
        BioTextBox.layer.cornerRadius = 11
        
        BioText.font = UIFont.bioFont
        BioTextBox.becomeFirstResponder()
        
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let xButton = UIBarButtonItem(image: UIImage(named: "x"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popToRoot(_:)))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = xButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateController" {
            // Pass data to CreateProfilePt2Controller
        }
    }
    
    @IBAction func nextButtonPressed (_ sender: Any?) {
        MAIN_USER.changeUserInfo(type: "bio", info: BioTextBox.text ?? "")
        //self.performSegue(withIdentifier: "EndPt1", sender: sender)
        self.performSegue(withIdentifier: "toCreateController", sender: sender)
    }
    
    @objc
    func popToRoot(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

