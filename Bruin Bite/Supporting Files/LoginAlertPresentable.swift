//
//  LoginAlertPresentable.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 4/22/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

// To use this protocol, make a segue with identifier "login"

protocol LoginAlertPresentable: class {}

extension LoginAlertPresentable where Self: UIViewController {

    func presentNotLoggedInAlert() {
        let alertController = UIAlertController(title: "Oh no!", message: "Sorry, you must be logged in for this feature!", preferredStyle: .alert)

        let loginAction = UIAlertAction(title: "Log In", style: .default) { (action:UIAlertAction!) in
            self.performSegue(withIdentifier: "login", sender: self)
        }
        alertController.addAction(loginAction)
        let backAction = UIAlertAction(title: "Go back", style: .default) { (action:UIAlertAction!) in
            self.tabBarController?.selectedIndex = 0
        }
        alertController.addAction(backAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
