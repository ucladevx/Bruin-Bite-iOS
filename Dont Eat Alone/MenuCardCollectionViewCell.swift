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
    var items: [Item] = []
    @IBOutlet weak var viewMoreButton: UIButton!
    var parentView: UICollectionView!
    var index: Int = -1
    
    @IBAction func viewMorePressed(_ sender: UIButton) {
        menuCard.tableExpanded = true
        menuCard.populateData(items: items, isFull: true)
        print(self.frame.height)
        var diff = menuCard.data.count - 3
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height+CGFloat(42*diff))
        
        menuCard.frame = CGRect(x: menuCard.frame.origin.x, y: menuCard.frame.origin.y, width: menuCard.frame.width, height: menuCard.frame.height+CGFloat(42*diff))
        
        menuCard.tableView.frame = CGRect(x: menuCard.tableView.frame.origin.x, y: menuCard.tableView.frame.origin.y, width: menuCard.tableView.frame.width, height: menuCard.tableView.frame.height+CGFloat(42*diff))
        
        viewMoreButton.frame = CGRect(x: viewMoreButton.frame.origin.x, y: viewMoreButton.frame.origin.y + CGFloat(42*diff), width: viewMoreButton.frame.width, height: viewMoreButton.frame.height)
        
        viewMoreButton.isHidden = true
        
         parentView.frame = CGRect(x: parentView.frame.origin.x, y: parentView.frame.origin.y, width: parentView.frame.width, height: parentView.frame.height+CGFloat(42*diff))
        
        var count = 0;
        for indexPath in parentView.indexPathsForVisibleItems.sorted() {
            if(count > self.index) {
                var cell = parentView.cellForItem(at: indexPath)
                cell?.frame = CGRect(x: (cell?.frame.origin.x)!, y: (cell?.frame.origin.y)!+CGFloat(42*diff), width: (cell?.frame.width)!, height: (cell?.frame.height)!)
            }
            count += 1
        }
        
        menuCard.tableView.reloadData()
    }
    
    func initializeData(data: [Item]) {
        items = data
        menuCard.populateData(items: items, isFull: false)
        menuCard.frame = self.bounds
    }
    
    
}
