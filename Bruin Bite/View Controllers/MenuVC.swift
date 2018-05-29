    //
//  MenuVC.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import Moya

class MenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let provider = MoyaProvider<API_methods>()
    
    @IBOutlet weak var allergensBar: AllergensBarScrollView!
    var topBar = TopBar()
    @IBOutlet weak var backgroundTopBar: UILabel!
    @IBOutlet weak var menuCardsCollection: UICollectionView!
    
    var menuData = MenuController()
    var activityLevelData = [ActivityLevel]()
    var hoursData = [String:[Location:HallHours]]()
    var currDate = "1"
    var currMP = MealPeriod.breakfast
    var currAllergens: [Allergen] = []
    
    var data: [Location: [Item]] = [:]
        
    let diningHalls = ["De Neve", "BPlate", "Covel", "Feast"]
    var menuItem: Item?
    
    var attrs = [
        NSAttributedStringKey.font: UIFont.signInFont.withSize(12.0),
        NSAttributedStringKey.foregroundColor: UIColor.twilightBlue,
        NSAttributedStringKey.underlineStyle: 1
        ] as [NSAttributedStringKey: Any]

        
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        super.viewDidLoad()
        allergensBar.content.parentVC = self
        topBar.parentVC = self
        menuCardsCollection.delegate = self
        menuCardsCollection.dataSource = self
        menuCardsCollection.alwaysBounceVertical = true
        menuCardsCollection.allowsSelection = false
        
        topBar.frame = CGRect(x:12.5, y:20, width: 350, height: 82)
        topBar.center.x = self.view.center.x
        self.view.addSubview(topBar)
        // Do any additional setup after loading the view, typically from a nib.
        API.getCurrentActivityLevels { (activityLevels) in
            for a in activityLevels{
                self.activityLevelData.append(a)
            }
        }
        API.getHours { (hours) in
            for d in hours {
                self.hoursData[d.key] = d.value
            }
        }
        API.getOverviewMenu { parsedMenus in
            for m in parsedMenus{
                self.menuData.menus.append(m)
            }
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            self.updateData(dateFormatter.string(from: date), mP: MealPeriod.breakfast)
        }
//        API.getDetailedMenu { parsedMenus in
//            for m in parsedMenus{
//                for i in 0..<(self.menuData.menus.count){
//                    if(self.menuData.menus[i].date == m.date){
//                        self.menuData.menus[i].detailedData = m.detailedData
//                    }
//                }
//            }
//        }
        backgroundTopBar.backgroundColor = UIColor.twilightBlue
        computedHeight = Array(repeating: defaultHeight, count: self.diningHalls.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    let defaultHeight: CGFloat = 235;
    var computedHeight: [CGFloat] = [];
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //computed height is only stored after a user presses the view more button, so we need to check for initial phase
        if computedHeight != []{
            return CGSize(width: collectionView.bounds.size.width, height: computedHeight[indexPath.row])
        }
        else{
            return CGSize(width: collectionView.bounds.size.width, height: defaultHeight)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func allergenUpdateData(_ a: Allergen, s: String){
        //print(a,s)
        if (s == "On") {
            currAllergens.append(a)
            for(loc, var items) in self.data{
                var i = 0
                while i < items.count{
                    if(a == Allergen.Vegan || a == Allergen.Vegetarian) {
                        if((items[i].allergies?.contains(a))! || (items[i].allergies?.contains(Allergen.Vegan))!){
                            i+=1
                        }
                        else{
                            items.remove(at: i)
                        }
                    }
                    else{
                        if(items[i].allergies?.contains(a))!{
                            items.remove(at: i)
                        }
                        else{
                            i+=1
                        }
                    }
                }
                self.data.updateValue(items, forKey: loc)
            }
            self.computedHeight = Array(repeating: self.defaultHeight, count: self.data.count)
            self.menuCardsCollection.reloadData()
        }
        else{
            currAllergens.remove(at: currAllergens.index(of: a)!)
            self.data = self.menuData.getOverviewMenu(date: currDate, mealPeriod: currMP) ?? [:]
            self.computedHeight = Array(repeating: self.defaultHeight, count: self.data.count)
            self.menuCardsCollection.reloadData()
        }
    }
    
    func updateData(_ d: String, mP: MealPeriod){
        currDate = d
        currMP = mP
        self.data = self.menuData.getOverviewMenu(date: d, mealPeriod: mP) ?? [:]
        if (currAllergens.isEmpty){
            self.computedHeight = Array(repeating: self.defaultHeight, count: self.data.count)
            self.menuCardsCollection.reloadData()
        }
        else{
            var tempAllergens = currAllergens
            currAllergens = []
            var i = tempAllergens.count-1
            var a: Allergen
            while i >= 0 {
                a = tempAllergens[i]
                tempAllergens.remove(at: i)
                allergenUpdateData(a, s: "On")
                i-=1
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCardsCollection.dequeueReusableCell(withReuseIdentifier: "menuCardCell", for: indexPath) as! MenuCardCollectionViewCell
        cell.menuCard.tableView.delegate = cell.menuCard
        cell.menuCard.tableView.isScrollEnabled = false
        cell.menuCard.tableView.allowsMultipleSelection = false
        cell.menuCard.tableView.dataSource = cell.menuCard
        cell.menuCard.parentVC = self
        
        cell.viewMoreButton.titleLabel?.font = UIFont.textStyle
        cell.viewMoreButton.titleLabel?.textColor = UIColor.twilightBlue
        
        cell.viewMoreButton.setTitleColor(UIColor.twilightBlue, for: .normal)
        cell.viewMoreButton.backgroundColor = UIColor.white
        
        cell.menuCard.diningHallName.text? = Array(data.keys)[indexPath.row].rawValue
        
        
        if let hall = Location(rawValue: Array(data.keys)[indexPath.row].rawValue) {
            var hoursText = ""
            switch currMP {
            case .breakfast:
                hoursText = hoursData[currDate]?[hall]?.breakfast ?? ""
            case .lunch, .brunch:
                hoursText = hoursData[currDate]?[hall]?.lunch ?? ""
            case .dinner:
                hoursText = hoursData[currDate]?[hall]?.dinner ?? ""
            case .lateNight:
                hoursText = hoursData[currDate]?[hall]?.late_night ?? ""
            }
            cell.menuCard.diningHallHours.text? = hoursText
        }
        else {
            cell.menuCard.diningHallHours.text? = ""
        }
        
        
        cell.initializeData(data: data[Array(data.keys)[indexPath.row]]!)
        
        cell.parentVC = self
        cell.parentView = self.menuCardsCollection
        cell.index = indexPath
        
        cell.viewMoreButton.backgroundColor = UIColor(red: 254.9 / 255.0, green: 254.9 / 255.0, blue: 254.9 / 255.0, alpha: 1.0)
        
        //make sure the button has multiple purposes
        //we need the count because in the beginning/refresh phase computedHeight = []
        if (computedHeight[indexPath.row] > defaultHeight){
            let text = NSMutableAttributedString(string:"View Less", attributes:attrs)
            cell.viewMoreButton.setAttributedTitle(text, for: .normal)
        }
        else{
            let text = NSMutableAttributedString(string:"View More", attributes:attrs)
            cell.viewMoreButton.setAttributedTitle(text, for: .normal)
        }

        cell.menuCard.activityLevelBar.resizeToZero()
        for a in activityLevelData{
            if (a.isAvailable && Array(data.keys)[indexPath.row] == a.location) {
                cell.menuCard.activityLevelBar.percentage = CGFloat(a.percent)/100
            }
            else if (Array(data.keys)[indexPath.row] == a.location){
                cell.menuCard.activityLevelBar.percentage = CGFloat(0)
            }
        }
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            cell.menuCard.activityLevelBar.animateBar()
        }) { (_) in }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showItemDetailViewControllerFor(menuItem: Item?) {
        self.menuItem = menuItem
        self.performSegue(withIdentifier: "segueToItemDetailVC", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToItemDetailVC") {
            let vc = segue.destination as! ItemDetailViewController
            vc.menuItem = self.menuItem
        }
    }
}

