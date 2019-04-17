//
//  MenuCardCollectionViewCell.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 2/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuCardCollectionViewCell: UICollectionViewCell {
    
    weak var parentVC: MenuVC?
    @IBOutlet weak var menuCard: MenuCardView!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    var location: String = ""
    var items: [Item] = []
    
    var parentView: UICollectionView!
    var index: IndexPath = []
    var computedHeight: CGFloat = 250
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        parentVC?.showDetailViewController(location: location, items: items)
    }
    
    func initializeData(diningHallName: String, data: [Item]) {
        self.items = data
        self.location = diningHallName

        menuCard.populateData(items: data)
    }
    
    
}
