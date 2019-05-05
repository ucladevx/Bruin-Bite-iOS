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

    var location: Location?
    var items: [Item] = []
    
    var parentView: UICollectionView!
    var index: IndexPath = []
    var computedHeight: CGFloat = 250
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        parentVC?.showDetailViewController(location: location)
    }

    func initializeData(location: Location, data: [Item]) {
        self.items = data
        self.location = location

        menuCard.populateData(items: data)
    }
    
    
}
