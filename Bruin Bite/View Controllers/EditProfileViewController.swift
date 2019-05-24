//
// Created by dc on 2019-05-11.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var bio: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func getUIYear(year: Int) -> String {
        switch (year) {
        case 1:
            return "1st Year"
        case 2:
            return "2nd Year"
        case 3:
            return "3rd Year"
        case 4:
            return "4th Year"
        default:
            return "Error Year"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
        profilePic.layer.shadowColor = UIColor.lightGray.cgColor
        profilePic.layer.shadowOffset = CGSize(width: 0, height: 1)
        profilePic.layer.shadowOpacity = 1
        profilePic.layer.shadowRadius = 1.0

        userName.text = UserDefaultsManager.shared.getFirstName()
        year.text = getUIYear(year: UserDefaultsManager.shared.getYear())
        major.text = UserDefaultsManager.shared.getMajor()
        bio.text = UserDefaultsManager.shared.getSelfBio()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if self.navigationController?.viewControllers.index(of: self) == nil {
            //TODO: this does not work
            if let userNameText = userName.text, let majorText = major.text, let yearText = year.text, let bioText = bio.text {
                UserManager.shared.signupUpdate(
                        email: UserDefaultsManager.shared.getUserEmail(),
                        first_name: userNameText,
                        last_name: "",
                        major: majorText,
                        minor: "",
                        year: 0,
                        self_bio: bioText
                )
            }
        }
        super.viewWillDisappear(animated)
    }
}

