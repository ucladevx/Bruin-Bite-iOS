//
//  BBStoryboard.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 9/26/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

enum BBStoryboardType: String {
    case main = "Main"
    case matching = "Matching"
    case chat = "Chat"
    case pop = "PopupViewControllers"
    case menu = "Menu"
}

enum BBStoryboardId: String {
    case cancelMatch = "CancelMatchViewController"
    case foundMatch = "MatchFoundViewController"
    case noMatch = "NoMatchViewController"
    case searching = "SearchingScreenViewController"
    case timePicker = "TimePickerViewController"
    case profile = "ProfileViewController"
    case preference = "PreferenceViewController"
    case menu = "MenuVC"
    case itemDetail = "ItemDetailViewController"
//    case matchList = "MatchingListViewController"
//    case collection = "CollectionViewController"
    case login = "LoginViewController"
    case createProfile = "CreateProfileViewController"
    case createProfile2 = "CreateProfilePt2ViewController"
    case signUp = "SignUpViewController"
    case signIn = "SignInViewController"
    case homeProfileTable = "HomeProfileStaticTableViewController"
    case chatList = "ChatListViewController"
    case chatScreen = "ChatScreenViewController"

    var id: String {
        return rawValue
    }

    var storyboardType: BBStoryboardType {
        switch self {
        case .menu, .itemDetail:
            return .menu
        case .searching, .noMatch, .foundMatch, .cancelMatch, .preference:
            return .matching
        case .profile, .login, .signIn, .signUp, .createProfile, .createProfile2, .homeProfileTable:
            return .main
        case .chatList, .chatScreen:
            return .chat
        case .timePicker:
            return .pop
        }
    }
}

class BBStoryboardFactory {

    private static func storyboard(_ bbStoryboardType: BBStoryboardType) -> UIStoryboard {
        return UIStoryboard(name: bbStoryboardType.rawValue, bundle: nil)
    }

    static func instantiate<T>(_ viewControllerType: T.Type, fromStoryboard bbStoryboardType: BBStoryboardType) -> T {
        let bbStoryboard = storyboard(bbStoryboardType)
        let identifier = String(describing: viewControllerType.self)
        return bbStoryboard.instantiateViewController(withIdentifier: identifier) as! T
    }

    static func instantiateInitialViewController<T>(_ bbStoryboardType: BBStoryboardType, as initialViewControllerType: T.Type) -> T {
        return storyboard(bbStoryboardType).instantiateInitialViewController() as! T
    }

    static func initiateViewController<T>(storyboardId: String, viewControllerType: T.Type, fromStoryboard bbStoryboardType: BBStoryboardType) -> T {
        return storyboard(bbStoryboardType).instantiateViewController(withIdentifier: storyboardId) as! T
    }

    static func initiateViewController<T>(storyboardId: BBStoryboardId, viewControllerType: T.Type) -> T {
        let storyboardType = storyboardId.storyboardType
        return storyboard(storyboardType).instantiateViewController(withIdentifier: storyboardId.id) as! T
    }
}


