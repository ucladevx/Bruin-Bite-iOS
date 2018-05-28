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

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let chatPreview1: ChatPreview = ChatPreview(name: "Josie Bruin", date: "04/22", meal: "Dinner", time: "10:30 PM", profileImage: "", unreadMessage: 2)
    var data: [ChatPreview] = []
    
    @IBOutlet weak var chatListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        data = [chatPreview1];
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
        cell.nameLabel.text = data[indexPath.row].name
        cell.timeLabel.text = data[indexPath.row].time
        cell.dateAndMealLabel.text = data[indexPath.row].date + " | " + data[indexPath.row].meal
        cell.unreadMessagesLabel.text = "\(data[indexPath.row].unreadMessage)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowChatScreenVC", sender: nil)
    }

}
