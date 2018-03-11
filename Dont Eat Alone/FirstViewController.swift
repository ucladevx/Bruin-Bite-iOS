    //
//  FirstViewController.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let provider = MoyaProvider<API_methods>()
    
    @IBOutlet weak var menuCardsCollection: UICollectionView!
    
    var menuData = MenuController()
    
    var data: [Item] = []
        
    let diningHalls = ["De Neve", "BPlate", "Covel", "Feast"]

        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var items = menuData.getOverviewMenu(mealPeriod: .breakfast, location: .bPlate)
        
        data = items!
        
        menuCardsCollection.delegate = self;
        menuCardsCollection.dataSource = self;
    }
    
    var height: CGFloat = 222;
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.cellForItem(at: indexPath) as? MenuCardCollectionViewCell
        return CGSize(width: collectionView.bounds.size.width, height: cell?.computedHeight ?? 222)
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCardsCollection.dequeueReusableCell(withReuseIdentifier: "menuCardCell", for: indexPath) as! MenuCardCollectionViewCell
        cell.menuCard.tableView.delegate = cell.menuCard
        cell.menuCard.tableView.dataSource = cell.menuCard
        cell.menuCard.diningHallName.text? = diningHalls[indexPath.row]
        cell.initializeData(data: data)
        cell.menuCard.activityLevelBar.resizeToZero()
        
        cell.parentView = self.menuCardsCollection
        cell.index = indexPath

        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            cell.menuCard.activityLevelBar.animateBar()
        }) { (_) in }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

