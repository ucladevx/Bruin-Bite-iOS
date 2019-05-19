//
//  BackgroungHighlightableButton.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 4/26/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

class BackgroundHighlightableButton: UIButton {
    @IBInspectable var highlightedBackgroundColor: UIColor?
    @IBInspectable var nonHighlightedBackgroundColor: UIColor?
    override var isHighlighted :Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.backgroundColor = highlightedBackgroundColor ?? nonHighlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
            super.isHighlighted = newValue
        }
    }
}
