//
//  NotificationService.swift
//  NotificationService
//
//  Created by Ayush Patel on 5/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            contentHandler(bestAttemptContent)
//        }
        
        guard let bestAttemptContent = bestAttemptContent, // 1. Make sure bestAttemptContent is not nil
            let apsData = bestAttemptContent.userInfo["aps"] as? [String: Any], // 2. Dig in the payload to get the
            let attachmentURLAsString = apsData["attachment-url"] as? String, // 3. The attachment-url
            let attachmentURL = URL(string: attachmentURLAsString) else { // 4. And parse it to URL
                return
        }
        
        // 6. Add some actions and add them in a category which is then added to the notificationCategories
        let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
        let saveAction = UNNotificationAction(identifier: "save", title: "Save", options: [])
        let category = UNNotificationCategory(identifier: "unicorning", actions: [likeAction, saveAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category]) 
        
        // 5. Download the image and pass it to attachments if not nil
        downloadImageFrom(url: attachmentURL) { (attachment) in
            if attachment != nil {
                bestAttemptContent.attachments = [attachment!]
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

// MARK: - Helper Functions
extension NotificationService {
    
    /// Use this function to download an image and present it in a notification
    ///
    /// - Parameters:
    ///   - url: the url of the picture
    ///   - completion: return the image in the form of UNNotificationAttachment to be added to the bestAttemptContent attachments eventually
    private func downloadImageFrom(url: URL, with completionHandler: @escaping (UNNotificationAttachment?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { (downloadedUrl, response, error) in
            // 1. Test URL and escape if URL not OK
            guard let downloadedUrl = downloadedUrl else {
                completionHandler(nil)
                return
            }
            
            // 2. Get current's user temporary directory path
            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())
            // 3. Add proper ending to url path, in the case .jpg (The system validates the content of attached files before scheduling the corresponding notification request. If an attached file is corrupted, invalid, or of an unsupported file type, the notification request is not scheduled for delivery. )
            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".jpg"
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)
            
            // 4. Move downloadedUrl to newly created urlPath
            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)
            
            // 5. Try adding getting the attachment and pass it to the completion handler
            do {
                let attachment = try UNNotificationAttachment(identifier: "picture", url: urlPath, options: nil)
                completionHandler(attachment)
            }
            catch {
                completionHandler(nil)
            }
        }
        task.resume()
}

}
