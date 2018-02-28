//
//  MenuCardCollectionViewCell.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuCardCollectionViewCell: UICollectionViewCell {
    var diningHallName: String = ""
    @IBOutlet weak var menuCard: MenuCardView!
    
    func initializeData(items: [Item]) {
        print(items)
        menuCard.populateData(items: items)
        menuCard.frame = self.bounds
    }
    
}
