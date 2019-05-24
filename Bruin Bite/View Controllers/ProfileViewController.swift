//
//  ProfileViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 4/29/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class ProfileViewController: UIViewController, ReadDelegate, AlertPresentable, LoginAlertPresentable, ProfilePictureDownloadDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var yearMajor: UILabel!
    @IBOutlet weak var shortBio: UITextView!
    
    private var COMING_SOON_POPUP: UIAlertController {
        get {
            let alert =  UIAlertController(title: "Edit Profile Coming Soon", message: "We're working hard on this feature and you will be able to edit your profile soon. Meanwhile you can email us at hello.bruin-bite@gmail.com with the profile changes you want and we'll update it for you!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            return alert
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.getUID() == -1 { presentNotLoggedInAlert() }

        fillInformation()
        //Set the labels/profile picture with default or old information
        UserManager.shared.readUser(email: UserDefaultsManager.shared.getUserEmail())

        ProfilePictureAPI().download(pictureForUserID: UserManager.shared.getUID(), delegate: self)
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

    func didReadUser() {
        fillInformation()
    }

    func fillInformation() {
        userName.text = combineFirstAndLastName(first: UserDefaultsManager.shared.getFirstName(),
                                                last: UserDefaultsManager.shared.getLastName())
        let year: Int = UserDefaultsManager.shared.getYear()
        let major: String = UserDefaultsManager.shared.getMajor()
        yearMajor.text = "Year: \(year)" + " | " + "Major: \(major)"
        shortBio.text = UserDefaultsManager.shared.getSelfBio()
    }

    @IBAction func didPressEditProfile(_ sender: Any) {
        self.present(COMING_SOON_POPUP, animated: true)
    }
    
    @IBAction func didPressFeedback(_ sender: Any) {
        guard let url = URL(string: "https://docs.google.com/forms/d/1sFffuMFWwTsIi7R9rIyRVTRysj_m9LH14XxGzbFsxPg/edit") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    
    func combineFirstAndLastName(first: String, last: String) -> String {
        let combined: String = first + " " + last
        return combined
    }

    func readFailed(error: String) {
        presentAlert(alert: error)
    }
}
