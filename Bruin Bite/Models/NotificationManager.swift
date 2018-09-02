//
//  Notifications.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 9/1/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import Whisper
import GSMessages
import SwiftEntryKit

class NotificationManager {
    static let shared = NotificationManager()
    private init() { }
    
    func notify(title:String, subtitle:String, image:UIImage, to: UIViewController, completion: (() -> Void)? = nil)
    {
        let announcement = Announcement(title: title, subtitle: subtitle, image: image)
        Whisper.show(shout: announcement, to: to, completion: completion)
    }
    func banner(type: GSMessageType, message: String, to view: UIViewController) {
        view.showMessage(message, type: type)
    }
    
}
