//
//  HomeProfileStaticTableViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/24/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class HomeProfileStaticTableViewController: UITableViewController {
    
    @IBOutlet var SettingsText: UILabel!
    @IBOutlet var FeedbackText: UILabel!
    @IBOutlet var EditProfileText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Edit Profile Label font, color size
        EditProfileText.textColor = UIColor.profileOptionGray
        EditProfileText.font = UIFont(name:"Avenir", size: 16.0)
        
        //Feedback Label font, color size
        FeedbackText.textColor = UIColor.profileOptionGray
        FeedbackText.font = UIFont(name:"Avenir", size: 16.0)
        
        //Settings Label font, color size
        SettingsText.textColor = UIColor.profileOptionGray
        SettingsText.font = UIFont(name:"Avenir", size: 16.0)
    }

}
