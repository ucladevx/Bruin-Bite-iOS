//
//  ComingSoonPopup.swift
//  Bruin Bite
//
//  Created by Ayush Patel on 5/30/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class ComingSoonPopup: UIView {
    @IBOutlet var contenView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){
        Bundle.main.loadNibNamed("ComingSoonPopup", owner: self, options: nil)
        addSubview(contenView)
        contenView.frame = self.bounds
        contenView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

