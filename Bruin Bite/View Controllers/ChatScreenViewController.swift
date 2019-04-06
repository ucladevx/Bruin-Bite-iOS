//
//  ChatScreenViewController.swift
//  Dont Eat Alone
//
//  Created by Hirday Gupta on 28/05/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Starscream
import UIKit

class MessageBubbleCell: UITableViewCell {
    @IBOutlet weak var receivedMessageLabel: UILabel!
    @IBOutlet weak var sentMessageLabel: UILabel!
    
    var debugData: ChatMessage = ChatMessage(timestamp: "", handle: "", message: "")
}

class ChatScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatMessagesDelegate, WebSocketDelegate {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var newMessageTxtField: UITextField!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
    var socket: WebSocket? = nil
    var isSocketConnected: Bool = false
    
    let currUserId = String(UserDefaultsManager.shared.getUserID())
    
    var messagesList: [ChatMessage] = []
    var chatRoomLabel: String? = nil
    
    let BACKEND_CHAT_WEBSOCKET_URL = "https://api.bruin-bite.com/api/v1/messaging/chat/"
    
    let chatAPI = ChatAPI()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
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
        self.chatAPI.getLast50Messages(forChatRoomWithLabel: chatRoomLabel)
        self.socket = WebSocket(url: URL(string: BACKEND_CHAT_WEBSOCKET_URL + (chatRoomLabel ?? ""))!)
        self.socket?.delegate = self
        self.socket?.connect()
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
    
    @IBAction func didPressSendMessage(_ sender: UIButton) {
        let newMessage = newMessageTxtField.text!
        self.newMessageTxtField.text = ""
        if !newMessage.isEmpty && self.isSocketConnected {
            let message = ChatMessageSend(handle: self.currUserId, message: newMessage)
            if let messageData = try? JSONEncoder().encode(message) {
                let stringedJSON = String(data: messageData, encoding: .utf8) ?? ""
                socket?.write(string: stringedJSON)
            } else {
                print ("Error converting ChatMessageSend object to Data")
            }
        }
    }
    func didReceiveMessages(messages: [ChatMessage]) {
        print (messages)
        self.messagesList = messages
        messagesTableView.reloadData()
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        self.isSocketConnected = true
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        self.isSocketConnected = false
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("MESSAGE RECEIVED!\n\n\n")
        print("LOOK IM SO COOL: ", text)
        if let dataFromMessage = text.data(using: .utf8, allowLossyConversion: false) {
            if let newMessage = try? JSONDecoder().decode(ChatMessage.self, from: dataFromMessage) {
                self.messagesList.insert(newMessage, at: 0)
                self.messagesTableView.reloadData()
            } else {
                print ("Error parsing websocket message to ChatMessage struct")
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // Code
    }
    
    @objc func keyboardUpdated(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        var updatedConstant = (view.bounds.maxY - convertedKeyboardEndFrame.minY) + 16
        // Slightly brute force-y, but desperate times call for desperate measures. - Hirday.
        if (updatedConstant < 0) {
            updatedConstant = 16
        }
        bottomLayoutConstraint.constant = updatedConstant
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUpdated(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUpdated(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
