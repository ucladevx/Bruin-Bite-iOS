//
//  ProfileViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 4/29/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController, ReadDelegate, AlertPresentable, LoginAlertPresentable, ProfilePictureDownloadDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var yearMajor: UILabel!
    @IBOutlet var ShortBio: UITextView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.getUID() == -1 { presentNotLoggedInAlert() }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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

        fillInformation()
        //Set the labels/profile picture with default or old information
        UserManager.shared.readUser(email: UserDefaultsManager.shared.getUserEmail())
        
        ProfilePictureAPI().download(pictureForUserID: UserManager.shared.getUID(), delegate: self)
    }
    
    func profilePicture(didDownloadimage image: UIImage, forUserWithID _: Int) {
        profilePic.image = image
    }
    
    func profilePicture(failedWithError error: String?) {
        print("Failed to download profile picture: \(error ?? "")")
    }

    func didReadUser() {
        fillInformation()
    }

    func fillInformation() {
        userName.text = combineFirstAndLastName(first: UserDefaultsManager.shared.getFirstName(),
                                                last: UserDefaultsManager.shared.getLastName())
        let year: Int = UserDefaultsManager.shared.getYear()
        let major: String = UserDefaultsManager.shared.getMajor()
        yearMajor.text = "Year: \(year)" + " " + "Major: \(major)"
        ShortBio.text = UserDefaultsManager.shared.getSelfBio()
    }

    func combineFirstAndLastName(first: String, last: String) -> String {
        let combined: String = first + " " + last
        return combined
    }

    func readFailed(error: String) {
        presentAlert(alert: error)
    }
}
