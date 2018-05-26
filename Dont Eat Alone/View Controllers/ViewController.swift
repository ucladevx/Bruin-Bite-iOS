/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Starscream
import Foundation
import SwiftyJSON
import Alamofire

final class ViewController: UIViewController {
    
    // MARK: - Properties
    var username = ""
    var CHAT_ROOM_LABEL = ""
    //var socket = WebSocket(url: URL(string: "https://django-channels-example.herokuapp.com/chat/devxdemo")!, protocols: ["chat"])
    var socket: WebSocket?
    //= WebSocket(url: URL(string: "http://localhost:8000/chat/devxdemo")!, protocols: ["chat"])
    
    // MARK: - IBOutlets
    @IBOutlet var emojiLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBAction func SendText(_ sender: UIButton) {
        sendMessage("Hello World")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLabel()
        navigationItem.hidesBackButton = true
    }
    
    func requestLabel() {
        let param = ["user1": 128, "user2": 456]
        
        Alamofire.request("http://localhost:8000/new/", method: HTTPMethod.get, parameters: param, headers: nil).responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                self.CHAT_ROOM_LABEL = json["label"].stringValue
                
                
                self.socket = WebSocket(url: URL(string: "http://localhost:8000/chat/" + self.CHAT_ROOM_LABEL)!, protocols: ["chat"])
                self.socket?.delegate = self
                self.socket?.connect()
                
                //  Load the last 50 messages from the server when the view controller loads
                Alamofire.request("http://localhost:8000/" + self.CHAT_ROOM_LABEL + "/").responseJSON { response in
                    if let result = response.result.value {
                        let json = JSON(result)
                        print(json["tester"])
                        print(json["messages"])
                    }
                }
            }
        }
    }
    
    deinit {
        socket?.disconnect(forceTimeout: 0)
        socket?.delegate = nil
    }
}

// MARK: - IBActions
extension ViewController {
    
    /*
    @IBAction func selectedEmojiUnwind(unwindSegue: UIStoryboardSegue) {
        guard let viewController = unwindSegue.source as? CollectionViewController,
            let emoji = viewController.selectedEmoji() else{
                return
        }
 
        sendMessage(emoji)
        
    }
 */
}

// MARK: - FilePrivate
fileprivate extension ViewController {
    
    func sendMessage(_ message: String) {
        
        
        let messageWrapper: [String: String] = [
            "handle": username,
            "message": message
        ]
        
        //  Stringify the dict
        do {
            print("Sending")
            let data = try JSONSerialization.data(withJSONObject: messageWrapper, options: .prettyPrinted)
            let stringedJSON = String(data: data, encoding: String.Encoding.utf8) ?? ""
            socket?.write(string: stringedJSON)
        }
        catch {
            print("Error sending message.")
        }
        
    }
    
    func messageReceived(_ message: String, senderName: String) {
        emojiLabel.text = message
        usernameLabel.text = senderName
    }
}

// MARK: - WebSocketDelegate
extension ViewController : WebSocketDelegate {
    public func websocketDidConnect(_ socket: Starscream.WebSocket) {
        print("WEBSOCKET DID CONNNECT!\n\n\n")
    }
    
    public func websocketDidDisconnect(_ socket: Starscream.WebSocket, error: NSError?) {
        performSegue(withIdentifier: "websocketDisconnected", sender: self)
    }
    
    
    public func websocketDidReceiveMessage(_ socket: Starscream.WebSocket, text: String) {
        print("MESSAGE RECEIVED!\n\n\n")
        print(text)
        
        
        if let dataFromString = text.data(using: .utf8, allowLossyConversion: false) {
            let json = try? JSON(data: dataFromString)
            let messageText = json!["message"].stringValue
            let messageAuthor = json!["handle"].stringValue
            messageReceived(messageText, senderName: messageAuthor)
        }
        
    }
    
    public func websocketDidReceiveData(_ socket: Starscream.WebSocket, data: Data) {
        
    }
}
