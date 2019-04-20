//
//  PresentAlert.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 12/4/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

protocol AlertPresentable: class {}

extension AlertPresentable where Self: UIViewController {
    func presentAlert(alert: String) {
        let alert = UIAlertController(title: "Error", message: alert, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
