//
//  ProfileViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 4/29/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController, ReadDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var yearMajor: UILabel!
    @IBOutlet var ShortBio: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.readDelegate = self

        self.hideKeyboardWhenTappedAround()
        //Set background color
        view.backgroundColor = UIColor.twilightBlue

        //Name Label font, color, size
        userName.textColor = UIColor.white
        userName.font = UIFont.profileNameFont

        //Year & Major Label font, color size
        yearMajor.textColor = UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)
        yearMajor.font = UIFont(name:"Avenir", size: 12.0)

        //Bio Text Box font, color size
        ShortBio.textColor = UIColor.white
        ShortBio.font = UIFont.profileNameFont.withSize(16)

        //Circular Profile Picture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.layer.shadowColor = UIColor.lightGray.cgColor
        profilePic.layer.shadowOffset = CGSize(width: 0, height: 1)
        profilePic.layer.shadowOpacity = 1
        profilePic.layer.shadowRadius = 1.0

        //Set the labels/profile picture with default or old information
//        UserManager.shared.readUser(email: )
    }

    func didReadUser() {
        //Update the labels with new data
    }
}
