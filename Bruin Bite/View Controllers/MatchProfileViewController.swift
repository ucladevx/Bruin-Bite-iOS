//
//  MatchProfileViewController.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 2/12/20.
//  Copyright © 2020 Dont Eat Alone. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class MatchProfileViewController: UIViewController, ProfilePictureDownloadDelegate, GetUserDelegate {
    

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var yearMajor: UILabel!
    @IBOutlet weak var shortBio: UITextView!
    
    var userProfile: UserCreate? = nil
    var userID: Int? = nil  //Set by segue

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if let id = userID {
            MatchingAPI().getUserById(completionDelegate: self, id: id)
            ProfilePictureAPI().download(pictureForUserID: id, delegate: self)
        }
        else {
             print("MatchProfileVC: User not provided.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        //Set background color
        view.backgroundColor = UIColor.twilightBlue

        //Name Label font, color, size
        userName.textColor = UIColor.white
        userName.font = UIFont.profileNameFont

        //Year & Major Label font, color size
        yearMajor.textColor = UIColor(red: 221.0 / 255.0, green: 221.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0)
        yearMajor.font = UIFont(name:"Avenir", size: 12.0)

        //Circular Profile Picture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.layer.shadowColor = UIColor.lightGray.cgColor
        profilePic.layer.shadowOffset = CGSize(width: 0, height: 1)
        profilePic.layer.shadowOpacity = 1
        profilePic.layer.shadowRadius = 1.0
    }
    
    func profilePicture(didDownloadimage image: UIImage, forUserWithID _: Int) {
        profilePic.image = image
    }
    
    func profilePicture(failedWithError error: String?) {
        print("Failed to download profile picture: \(error ?? "")")
    }
    
    func didReceiveUser(userData: UserCreate) {
        userProfile = userData
        fillInformation()
    }

    func fillInformation() {
        guard let user = userProfile else { return }
        userName.text = user.first_name
        let year = user.year
        let major = user.major
        yearMajor.text = "Year: \(year)" + " | " + "Major: \(major)"
        shortBio.text = user.self_bio
    }
}
