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

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var signUpUIView: UIView!
    @IBOutlet var registrationUIView: UIView!
    
    var yearPicker: UIPickerView! = UIPickerView()
    var pickerData = ["", "First Year", "Second Year", "Third Year", "Fourth Year", "Other"]
    
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
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        yearTextField.inputView = yearPicker
        
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
      self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (row == 0) {
            return "Select One"
        }
        else {
            return pickerData[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextField.text = pickerData[row]
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
            
            if( sender as? UIButton == useFacebookButton){
                UserProfile.loadCurrent({ (result) in
                    switch(result)
                    {
                    case .failed(let error):
                        self.registrationTitleLabel.text = "Welcome!"
                        print("User Profile did not load.")
                        print(error)
                    case .success(let profile):
                        self.registrationTitleLabel.text = "Welcome \(profile.firstName!)!"
                        print("NAME: " + profile.fullName!)
                        
                        //Pull in profile picture
                        let session = URLSession(configuration: .default)
                        
                        let URL_IMAGE = URL(string: "https://graph.facebook.com/\(profile.userId)/picture?width=640&height=640")
                        
                        //creating a dataTask
                        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
                            
                            //if there is any error
                            if let e = error {
                                //displaying the message
                                print("Error Occurred: \(e)")
                                
                            } else {
                                //in case of now error, checking wheather the response is nil or not
                                if (response as? HTTPURLResponse) != nil {
                                    
                                    //checking if the response contains an image
                                    if let imageData = data {
                                        
                                        //getting the image
                                        let image = UIImage(data: imageData)
                                        
                                        print("PROFILE PICTURE: \(image!)")
                                        
                                    } else {
                                        print("Image file is currupted")
                                    }
                                } else {
                                    print("No response from server")
                                }
                            }
                        }
                        //starting the download task
                        getImageFromUrl.resume()
                        
                        
                        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
                        request.start { (response, result) in
                            switch result {
                            case .success(let value):
                                print("EMAIL: \((value.dictionaryValue?["email"])!)")
                            case .failed(let error):
                                print(error)
                            }
                        }
                        //TODO
                        //Save User's Name here
                    }
                })
                
            }
            
            
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
    
    @IBAction func unwind(_ sender: UIStoryboardSegue){
        self.majorTextField.becomeFirstResponder()
        self.yearTextField.becomeFirstResponder()
    }
}
