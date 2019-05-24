//
// Created by dc on 2019-05-11.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var year: UISegmentedControl!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var bio: UITextView!
    @IBOutlet weak var bioChar: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
        year.selectedSegmentIndex = UserDefaultsManager.shared.getYear() - 1
        major.text = UserDefaultsManager.shared.getMajor()
        bio.text = UserDefaultsManager.shared.getSelfBio()
        bio.delegate = self
        bioChar.text = "\(bio.text.count)"
    }

    override func viewWillDisappear(_ animated: Bool) {
        if self.navigationController?.viewControllers.index(of: self) == nil {
            if let userNameText = userName.text,
               let majorText = major.text,
               let bioText = bio.text {
                print(year.selectedSegmentIndex)
                UserManager.shared.signupUpdate(
                        email: UserDefaultsManager.shared.getUserEmail(),
                        first_name: userNameText,
                        last_name: "",
                        major: majorText,
                        minor: "",
                        year: year.selectedSegmentIndex + 1,
                        self_bio: bioText
                )
            }
        }
        super.viewWillDisappear(animated)
    }

    func textView(_ BioTextBox: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (BioTextBox.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        self.bioChar.text = "\(numberOfChars)"
        return numberOfChars < 250    // 250 character limit for Bio
    }
}

