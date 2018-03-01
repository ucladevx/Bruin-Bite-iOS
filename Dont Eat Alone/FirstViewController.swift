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

        self.menuCardsCollection.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y+125, width: UIScreen.main.bounds.width, height: 600)
//        self.menuCardsCollection.frame = UIScreen.main.bounds
    }
    
    @IBAction func callAPI(_ sender: Any) {
        provider.request(.getAllMenus) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    try moyaResponse.filterSuccessfulStatusCodes() //makes sure the status code is 200...299
                    let data = try moyaResponse.mapJSON()
                    print(data)
                }
                catch{
                    let statusCode = moyaResponse.statusCode
                    print(statusCode)
                }
                
            // do something with the response data or statusCode
            case let .failure(error):
                print("Error")                  // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.size.width, height: 222)
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

