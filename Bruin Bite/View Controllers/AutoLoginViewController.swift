//
//  AutoLoginViewController.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 12/4/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class AutoLoginViewController: UIViewController, ReadDelegate, RefreshDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.readDelegate = self
        UserManager.shared.refreshDelegate = self
        activityIndicator.startAnimating()
        UserManager.shared.readUser(email: UserDefaultsManager.shared.getUserEmail())
    }

    func didReadUser() {
        activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "loggedIn", sender: nil)
    }

    func readFailed(error: String) {
        UserManager.shared.getNewAccessToken(refreshToken: UserDefaultsManager.shared.getRefreshToken())
    }

    func didRefreshToken() {
        UserManager.shared.readUser(email: UserDefaultsManager.shared.getUserEmail())
    }

    func refreshFailed() {
        activityIndicator.stopAnimating()
        UserManager.shared.logOutUser(token: UserManager.shared.getAccessToken())
        self.performSegue(withIdentifier: "notLogged", sender: nil)
    }

    func networkFailure() {
        activityIndicator.stopAnimating()
        self.performSegue(withIdentifier: "loggedIn", sender: nil)
    }
}
