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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting Label font, color, size
        userName.textColor = UIColor.red
        userName.font = UIFont(name:"Avenir", size: 28.0)
        //Setting Label font, color size
        yearMajor.textColor = UIColor.gray
        yearMajor.font = UIFont(name:"Avenir", size: 14)
        
        //Align text to center
        userName.textAlignment = NSTextAlignment.center
        yearMajor.textAlignment = NSTextAlignment.center
        
        //Set labels equal to name
        userName.text = MAIN_USER.accessUserInfo(type: "first")
        let combine = String(MAIN_USER.accessUserYear()) + " | " + MAIN_USER.accessUserInfo(type: "major")
        yearMajor.text = combine
        
        //set profile picture
        profilePic.image = John.pic
        
        //Circular Profile Picture
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        
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
