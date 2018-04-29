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

    @IBOutlet var signUpUIView: UIView!
    @IBOutlet var registrationUIView: UIView!
    
    
    @IBOutlet weak var registrationTitleLabel: UILabel!
    @IBOutlet weak var signUpTitleLabel: UILabel!
    @IBOutlet weak var toggleSignupButton: UIButton!
    @IBOutlet weak var useFacebookButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    var dietaryRestrictions = [String : Bool]()
    var isSigningUp: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrationUIView.isHidden = true
        
        registrationUIView.layer.shadowColor = UIColor.black.cgColor
        registrationUIView.layer.shadowOpacity = 0.5
        registrationUIView.layer.shadowOffset = CGSize.init(width: 0.5, height: 0.6)
        registrationUIView.layer.shadowRadius = 10
        
        UserProfile.loadCurrent({ (result) in
            switch(result)
            {
            case .failed(let error):
                self.registrationTitleLabel.text = "Welcome!"
                print("User Profile did not load.")
                print(error)
            case .success(let profile):
                self.registrationTitleLabel.text = "Welcome \(profile.firstName!)!"
                //TODO
                //Save User's Name here
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editField(_ sender: UITextField)
    {
        sender.backgroundColor = UIColor.white
    }
    
    @IBAction func dismissKeyboard(_ sender: Any){
        self.view.endEditing(true)
    }
    
    @IBAction func focusNextField(_ sender: UITextField){
        if (sender == emailTextField)
        {
            passwordTextField.becomeFirstResponder()
        }
        else if (sender == yearTextField)
        {
            majorTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func cont (_ sender: Any){
        if(isSigningUp) {
            registrationUIView.frame.origin.x = signUpUIView.frame.width
            registrationUIView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.registrationUIView.frame.origin.x = 0
            }) { (_) in
                self.signUpUIView.isHidden = true;
            }
            
            yearTextField.becomeFirstResponder()
        }
        else {
            performSegue(withIdentifier: "FinishRegistration", sender: nil)
        }
    }
    
    @IBAction func back (_ sender: Any) {
        signUpUIView.isHidden = false;
        UIView.animate(withDuration: 0.5, animations: {
            self.registrationUIView.frame.origin.x = self.signUpUIView.frame.width
        }) { (_) in
            self.registrationUIView.isHidden = true;
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func useFacebookButtonAction(sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print("Error:::::::\(error)")
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                
                if(self.isSigningUp) {
                    self.cont(sender)
                }
                else {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
                    self.present(nextViewController, animated:false, completion:nil)
                }
            }
        }
    }
    
    @IBAction func toggleSignupOrSignin (_ sender: Any) {
        isSigningUp = !isSigningUp
        var text: String?
        if (isSigningUp) {
            text = "Sign Up"
            toggleSignupButton.setTitle("Already have an account? Sign In", for: UIControlState.normal)
        }
        else {
            text = "Sign In"
            toggleSignupButton.setTitle("Don't have an account yet? Sign Up", for: UIControlState.normal)
        }
        signUpTitleLabel.text = text!
        useFacebookButton.titleLabel?.text = text! + " with Facebook"
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
            performSegue(withIdentifier: "ContinueRegistration", sender: nil)
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
