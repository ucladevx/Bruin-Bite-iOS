//
//  ChatListViewController.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 26/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateAndMealLabel: UILabel!
    @IBOutlet weak var unreadMessagesLabel: UILabel!
}

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatListDelegate, LoginAlertPresentable, ProfilePictureDownloadDelegate {

    var data: [Match] = []
    var profilePictures: [Int : UIImage] = [:]
    var selectedChat: Match? = nil
    
    let chatListAPI: ChatListAPI = ChatListAPI()
    
    @IBOutlet weak var chatListTableView: UITableView!
    @IBOutlet weak var defaultTextLabel: UILabel!
    
    private var isChatListEmpty: Bool? = nil {
        didSet {
            self.chatListTableView.isHidden = isChatListEmpty ?? false
            self.defaultTextLabel.isHidden = !(isChatListEmpty ?? false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        chatListAPI.delegate = self
        //chatListAPI.getChatList(forUserWithID: "31"); // TODO: Send current user's chat ID instead of sample ID
        chatListAPI.getChatList(forUserWithID: UserDefaultsManager.shared.getUserID())
        //data = [chatPreview1];
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserManager.shared.getUID() == -1 { presentNotLoggedInAlert() }
        chatListAPI.delegate = self
        chatListAPI.getChatList(forUserWithID: UserDefaultsManager.shared.getUserID())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // code here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListTableViewCell
        cell.nameLabel.text = data[indexPath.row].user2_first_name + " " + data[indexPath.row].user2_last_name
        cell.profileImage.image = profilePictures[data[indexPath.row].user2] ?? UIImage(named: "DefaultProfile")
        var dateString = ""
        var timeString = ""
        if let date = getDateObject(fromDateTimeString: data[indexPath.row].meal_datetime) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            dateFormatter.dateFormat = "MM/dd"
            dateString = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "h:mm a"
            timeString = dateFormatter.string(from: date)
        } else {
            print ("Error parsing meal_datettime into date object using DateFormatter")
        }
        //cell.timeLabel.text = timeString
        cell.dateAndMealLabel.text = dateString + " | " + getMealPeriodString(fromMealPeriodCode: data[indexPath.row].meal_period) + " | " + timeString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedChat = data[indexPath.row]
        self.performSegue(withIdentifier: "ShowChatScreenVC", sender: nil)
    }
    
    func didReceiveChatList(chatListData: [Match]) {
        self.isChatListEmpty = chatListData.isEmpty
        self.data = chatListData
        for chatListItem in data{
            ProfilePictureAPI().download(pictureForUserID: chatListItem.user2, delegate: self)
        }
        self.chatListTableView.reloadData()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowChatScreenVC" {
            return selectedChat != nil
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChatScreenVC" {
            if let destVC = segue.destination as? ChatScreenViewController {
                destVC.chatItem = selectedChat
            }
        }
    }
    @IBAction func unwindToChatListViewController(segue: UIStoryboardSegue) {
    }
    
    func profilePicture(didDownloadimage image: UIImage, forUserWithID userID: Int) {
        profilePictures[userID] = image
        self.chatListTableView.reloadData()
    }
    
    func profilePicture(failedWithError error: String?) {
        print("Could not download profile photo\(error ?? "")")
    }
    
    // UTILITY FUNCTIONS:
    
    func getDateObject(fromDateTimeString dateTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateTime)
    }
    
    // TODO: Move this function to a more utility location
    func getMealPeriodString(fromMealPeriodCode mealPeriodCode: String) -> String {
        switch mealPeriodCode {
        case "LU":
            return "Lunch"
        case "BR":
            return "Breakfast"
        case "DI":
            return "Dinner"
        default:
            print("Invalid meal period passed in")
            return ""
        }
    }

}
