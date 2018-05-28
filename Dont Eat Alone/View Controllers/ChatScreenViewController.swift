//
//  ChatScreenViewController.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 28/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

class MessageBubbleCell: UITableViewCell {
    @IBOutlet weak var receivedMessageLabel: UILabel!
    @IBOutlet weak var sentMessageLabel: UILabel!
    var debugData: ChatMessage = ChatMessage(timestamp: "", handle: "", message: "")
}

class ChatScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatMessagesDelegate {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    let currUserId = "123"
    
    var messagesList: [ChatMessage] = []
    let chatAPI = ChatAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.messagesTableView.delegate = self
        self.messagesTableView.dataSource = self
        self.messagesTableView.allowsSelection = false
        self.messagesTableView.separatorColor = UIColor.clear
        
        self.messagesTableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        self.messagesTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.messagesTableView.bounds.size.width - 8.0)

        self.chatAPI.delegate = self
        self.chatAPI.getChatLabel(user1: "123", user2: "456")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBubbleCell") as! MessageBubbleCell
        let currMessage = messagesList[indexPath.row]
        cell.debugData = currMessage
        if (currMessage.handle == currUserId) {
            cell.sentMessageLabel.isHidden = false
            cell.sentMessageLabel.text = currMessage.message
            cell.receivedMessageLabel.isHidden = true
        } else {
            cell.sentMessageLabel.isHidden = true
            cell.receivedMessageLabel.isHidden = false
            cell.receivedMessageLabel.text = currMessage.message
        }
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MessageBubbleCell
        print (cell.debugData)
    }
    
    func didReceiveLabel(label: String) {
        print (label)
        chatAPI.getLast50Messages(forChatRoomWithLabel: label)
    }
    
    func didReceiveMessages(messages: [ChatMessage]) {
        print (messages)
        self.messagesList = messages
        messagesTableView.reloadData()
    }
}
