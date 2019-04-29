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
    @IBOutlet weak var receivedMessageLabel: UITextView!
    @IBOutlet weak var sentMessageLabel: UITextView!

    var debugData: ChatMessage = ChatMessage(timestamp: "", handle: "", message: "")
}

class ChatScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatMessagesDelegate, WebSocketDelegate, UITextViewDelegate {
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var newMessageTextField: UITextView!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    var socket: WebSocket? = nil
    var isSocketConnected: Bool = false

    let currUserId = String(UserDefaultsManager.shared.getUserID())

    var messagesList: [ChatMessage] = []

    var chatItem: ChatListItem? = nil

    // get-only "var"
    var BACKEND_CHAT_WEBSOCKET_URL: String {
        get {
            return "https://api.bruin-bite.com/api/v1/messaging/chat/"
        }
    }

    let chatAPI = ChatAPI()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround(self.messagesTableView)

        self.messagesTableView.delegate = self
        self.messagesTableView.dataSource = self
        self.messagesTableView.allowsSelection = false
        self.messagesTableView.separatorColor = UIColor.clear

        self.messagesTableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        self.messagesTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.messagesTableView.bounds.size.width - 8.0)

        self.chatAPI.delegate = self
        self.chatAPI.getLast50Messages(forChatRoomWithLabel: chatItem?.chat_url)
        self.socket = WebSocket(url: URL(string: BACKEND_CHAT_WEBSOCKET_URL + (chatItem?.chat_url ?? ""))!)
        self.socket?.delegate = self
        self.socket?.connect()

        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(didPressInfo), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        self.title = chatItem?.user2_first_name
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
            cell.receivedMessageLabel.text = ""
        } else {
            cell.sentMessageLabel.isHidden = true
            cell.sentMessageLabel.text = ""
            cell.receivedMessageLabel.isHidden = false
            cell.receivedMessageLabel.text = currMessage.message
        }
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        cell.sizeToFit()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MessageBubbleCell
        print (cell.debugData)
    }

    @IBAction func didPressSendMessage(_ sender: UIButton?) {
        let newMessage = newMessageTextField.text!
        self.newMessageTextField.text = ""
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

    @IBAction func didPressInfo(_sender: Any?){
        self.performSegue(withIdentifier: "showChatDetails", sender: nil)
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
        let updatedConstant = max((view.bounds.maxY - convertedKeyboardEndFrame.minY), 0)
        // Slightly brute force-y, but desperate times call for desperate measures. - Hirday.
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            didPressSendMessage(nil)
            return false
        }
        return true
    }

    @IBAction func unwindToChatViewController(segue: UIStoryboardSegue) {

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ChatDetailsViewController {
            let mealDateTime = Date(fromMatchRequestMealTimeString: chatItem?.meal_datetime ?? "")
            dest.day = mealDateTime?.userFriendlyMonthDayYearString()
            dest.diningHall = diningHallName(forDiningHallCode: chatItem?.dining_hall ?? "")
            dest.mealPeriod = mealPeriodName(forMealPeriodCode: chatItem?.meal_period ?? "")
            dest.time = mealDateTime?.hourMinuteString()
            
            /* TEST DATA for dev purposes, delete after work is complete
             dest.day = "11th November 2019"
             dest.diningHall = "Covel"
             dest.mealPeriod = "Dinner"
             dest.time = "6:00 pm"
            */
        }
    }
}
