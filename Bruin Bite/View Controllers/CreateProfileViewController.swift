//
//  CreateProfileViewController.swift
//  Dont Eat Alone
//  Created by Kameron Carr on 4/29/18.
//  Created by Cynthia Zhou on 5/13/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profilePic: UIImage!
    var imagePickerController: UIImagePickerController?
    
    @IBOutlet weak var BioPic: UIImageView!
    
    @IBOutlet var BioText: UILabel!
    
    @IBOutlet var BioTextBox: UITextView!
    
    @IBOutlet weak var BioTextBoxChar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.twilightBlue
        BioTextBox.layer.borderWidth = 1
        BioTextBox.layer.borderColor = UIColor.white.cgColor
        BioTextBox.layer.cornerRadius = 11
        
        BioText.font = UIFont.bioFont
        BioTextBox.becomeFirstResponder()
        BioTextBox.delegate = self
        
        Utilities.sharedInstance.formatNavigation(controller: self.navigationController!)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 17.0)!]
        
        BioPic.layer.masksToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(picTapped(tapGestureRecognizer:)))
        BioPic.isUserInteractionEnabled = true
        BioPic.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    @objc func picTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        // Allows user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        
        alertController.addAction(photoLibraryAction)
        
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .default) { (action) in
                self.showImagePickerController(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        present(imagePickerController!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

                self.BioPic.layer.cornerRadius = BioPic.frame.height/2
                self.profilePic = pickedImage
                self.BioPic.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func textView(_ BioTextBox: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (BioTextBox.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        self.BioTextBoxChar.text = "\(numberOfChars)"
        return numberOfChars < 250    // 250 character limit for Bio
    }
    
}

