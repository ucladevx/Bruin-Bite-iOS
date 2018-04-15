//
//  RegistrationViewController.swift
//  Dont Eat Alone
//
//  Created by Kameron Carr on 4/8/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class RegistrationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    var dietaryRestrictions = [String : Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserProfile.loadCurrent({ (result) in
            switch(result)
            {
            case .failed(let error):
                self.titleLabel.text = "Welcome!"
                print("\n*****User Profile did not load.*****\n")
                print(error)
            case .success(let profile):
                self.titleLabel.text = "Welcome \(profile.firstName!)!"
                //TODO
                //Save User's Name here
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editField(_ sender: UITextField)
    {
        sender.backgroundColor = UIColor.white
    }
    
    @IBAction func saveButton(_ sender: Any) {
        var isValid = true;
        
        if( yearTextField.text == "" )
        {
            yearTextField.backgroundColor = UIColor.red
            isValid = false;
        }
        if( majorTextField.text == "" )
        {
            majorTextField.backgroundColor = UIColor.red
            isValid = false;
        }
        
        if( isValid )
        {
            //TODO
            //Save Info From Registration Form Here
            performSegue(withIdentifier: "FinishRegistration", sender: nil)
        }
    }
    
    @IBAction func highlightRestriction(_ sender: UIButton){
        guard let buttonText = sender.titleLabel?.text else
        {
            return;
        }
        
        if dietaryRestrictions[buttonText] == nil {
            dietaryRestrictions[buttonText] = false;
        }
        
        let isRestricted = !(dietaryRestrictions[buttonText]!)
        dietaryRestrictions[buttonText] = isRestricted
        
        if(isRestricted)
        {
            sender.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
            sender.tintColor = UIColor.white
        }
        else{
            sender.backgroundColor = UIColor.white
            sender.tintColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
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
