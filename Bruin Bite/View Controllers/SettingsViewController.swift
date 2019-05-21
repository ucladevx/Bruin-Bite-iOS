//
//  SettingsViewController.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 5/21/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        // code
    }
    
    @IBAction func didPressLogout(_ sender: Any) {
        UserManager.shared.logOutUser(token: UserManager.shared.getAccessToken())
        self.performSegue(withIdentifier: "segueToLogin", sender: nil)
    }
    
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var AnnouncementsCell: UITableViewCell!
    @IBOutlet weak var MatchNotifsCell: UITableViewCell!
    @IBOutlet weak var ChatNotifsCell: UITableViewCell!
    @IBOutlet weak var PrivacyPolicyCell: UITableViewCell!
    @IBOutlet weak var ToSCell: UITableViewCell!
    
    private var COMING_SOON_POPUP: UIAlertController {
        get {
            let alert =  UIAlertController(title: "Notification Settings Coming Soon", message: "We're working hard on this feature and you will be able to control your notification settings ssoon!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            return alert
        }
    }

    override func viewDidLoad() {
        AnnouncementsCell.selectionStyle = .none
        MatchNotifsCell.selectionStyle = .none
        ChatNotifsCell.selectionStyle = .none
    }
    
    @IBAction func didSwitchAnnouncements(_ sender: Any) {
        self.present(COMING_SOON_POPUP, animated: true)
    }
    
    @IBAction func didSwitchMatchNotifs(_ sender: Any) {
        self.present(COMING_SOON_POPUP, animated: true)
    }
    
    @IBAction func didSwitchChatNotifs(_ sender: Any) {
        self.present(COMING_SOON_POPUP, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) else {
            return
        }
        cell.isSelected = false
        switch cell {
        case PrivacyPolicyCell:
            guard let url = URL(string: "https://tinyurl.com/bruin-bite-pp") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true)
        case ToSCell:
            guard let url = URL(string: "https://tinyurl.com/bruin-bite-tos") else {
                return
            }
            let vc = SFSafariViewController(url: url)
            self.present(vc,animated: true)
        default:
            break
        }
    }
    
}
