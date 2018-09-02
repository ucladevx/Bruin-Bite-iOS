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
    func popup(title: String, subtitle: String) {
        var attributes = EKAttributes.centerFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [.red, .green], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        let EKTitle = EKProperty.LabelContent(text: title, style: .init(font: UIFont.boldSystemFont(ofSize: 21), color: UIColor.black))
        let EKSubTitle = EKProperty.LabelContent(text: subtitle, style: .init(font: UIFont.boldSystemFont(ofSize: 21), color: UIColor.black))
        let button = EKProperty.ButtonContent(label: EKProperty.LabelContent(text: "Dismiss", style: .init(font: UIFont.boldSystemFont(ofSize: 18), color: UIColor.black)), backgroundColor: UIColor.white, highlightedBackgroundColor: UIColor.red)
        let popup = EKPopUpMessage(topImage: EKProperty.ImageContent(image: UIImage()), title: EKTitle, description: EKSubTitle, button: button) {
            SwiftEntryKit.dismiss()
        }
        let contentView = EKPopUpMessageView(with: popup)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
