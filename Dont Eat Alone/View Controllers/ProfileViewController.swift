//
//  ProfileViewController.swift
//  Dont Eat Alone
//
//  Created by Ryan Lee on 4/29/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController {


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var yearMajor: UILabel!
    @IBOutlet var ShortBio: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MAIN_USER.readUser()
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

        //Align text to center
//        userName.textAlignment = NSTextAlignment.center
//        yearMajor.textAlignment = NSTextAlignment.center
//        ShortBio.textAlignment = NSTextAlignment.center

        //Set labels equal to name
//        userName.text = MAIN_USER.accessUserInfo(type: "first")
        let combine = String(MAIN_USER.accessUserYear()) + " | " + MAIN_USER.accessUserInfo(type: "major")
//        yearMajor.text = combine

        //set profile picture
        //profilePic.image = John.pic

        //Set Bio Text
        let text = "I love dancing, singing and meeting new people. Let’s grab a meal and get to know each other!"
//        ShortBio.text = text

        //Circular Profile Picture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        profilePic.layer.shadowColor = UIColor.lightGray.cgColor
        profilePic.layer.shadowOffset = CGSize(width: 0, height: 1)
        profilePic.layer.shadowOpacity = 1
        profilePic.layer.shadowRadius = 1.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
