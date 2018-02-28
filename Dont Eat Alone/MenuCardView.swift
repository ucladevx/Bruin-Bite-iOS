//
//  MenuCardView.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable
class MenuCardView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var menuCardView: UIView!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    var data: [Item]
    
    //for using custom view in code
    override init(frame: CGRect){
        self.data = []
        super.init(frame: frame)
        commonInit()
    }

    //for using custom view in Interface Builder
    required init?(coder aDecoder: NSCoder) {
        self.data = []
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func populateData(items: [Item]) {
        for item in items {
            data.append(item)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.count when view more is pressed
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    private func commonInit(){
        
        Bundle.main.loadNibNamed("MenuCardView", owner: self, options: nil)
        addSubview(menuCardView)
        menuCardView.addSubview(tableView)
        menuCardView.addSubview(activityLevelBar)
        menuCardView.addSubview(diningHallName)
        menuCardView.addSubview(viewMoreButton)
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        menuCardView.center.x = self.center.x
        menuCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        menuCardView.backgroundColor = .white
        menuCardView.layer.cornerRadius = 8
        
//        menuCardView.layer.shadowColor = UIColor.black.cgColor
//        menuCardView.layer.shadowOpacity = 1
//        menuCardView.layer.shadowOffset = CGSize.zero
//        menuCardView.layer.shadowRadius = 10
        
        menuCardView.layer.shadowColor = UIColor.black.cgColor;
        menuCardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        menuCardView.layer.shadowOpacity = 1;
        menuCardView.layer.shadowRadius = 1.0;
        menuCardView.layer.masksToBounds = false;
        
        let convert_bar_bounds = menuCardView.convert(activityLevelBar.frame, from: menuCardView)
        
        let bar_height = activityLevelBar.frame.height
       
        _ = tableView.convert(tableView.frame, from: menuCardView)
        _ = diningHallName.convert(diningHallName.frame, from: menuCardView)
        _ = viewMoreButton.convert(viewMoreButton.frame, from: menuCardView)
        
        //activityLevelBar.frame.origin = CGPoint(x: a.frame.origin.x, y: activityLevelBar.bounds.origin.y)
        activityLevelBar.frame = CGRect(x: activityLevelBar.bounds.origin.x+58, y: activityLevelBar.bounds.origin.y, width: UIScreen.main.bounds.size.width, height: 7.9)
//        activityLevelBar.frame = CGRect(x: activityLevelBar.bounds.origin.x+90, y: activityLevelBar.bounds.origin.y, width: UIScreen.main.bounds.size.width, height: bar_height)
        tableView.frame = CGRect(x: tableView.bounds.origin.x+58, y: tableView.bounds.origin.y+45, width: menuCardView.bounds.width, height: 126)
        diningHallName.frame = CGRect(x: diningHallName.bounds.origin.x+70, y: diningHallName.bounds.origin.y+19, width: diningHallName.bounds.width, height: diningHallName.bounds.height)
        viewMoreButton.frame = CGRect(x: viewMoreButton.bounds.origin.x+180, y: viewMoreButton.bounds.origin.y+180, width: viewMoreButton.bounds.width, height: viewMoreButton.bounds.height)
        
        menuCardView.clipsToBounds = true
        
    }
}


/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */
