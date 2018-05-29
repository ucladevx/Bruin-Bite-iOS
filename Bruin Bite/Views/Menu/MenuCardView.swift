//
//  MenuCardView.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/19/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class MenuCardView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var greyBackground: UIView!
    @IBOutlet weak var menuCardView: UIView!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var diningHallHours: UILabel!
    
    var data: [Item]
    weak var parentVC: MenuVC?
    let clockIcon = UIImageView(image: #imageLiteral(resourceName: "clock"))
    
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
        data = items
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.count when view more is pressed
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row].name
        cell.textLabel?.textColor = UIColor.MenuItemGray
        cell.textLabel?.font = UIFont.textStyle
        cell.indentationWidth = 13
        cell.indentationLevel = 1
        cell.preservesSuperviewLayoutMargins = true
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.parentVC?.showItemDetailViewControllerFor(menuItem: data[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("MenuCardView", owner: self, options: nil)
        addSubview(menuCardView)
        menuCardView.addSubview(tableView)
        menuCardView.addSubview(greyBackground)
        menuCardView.addSubview(activityLevelBar)
        menuCardView.addSubview(diningHallName)
        menuCardView.addSubview(diningHallHours)
        menuCardView.addSubview(clockIcon)
        menuCardView.backgroundColor = .clear
        diningHallName.font = UIFont.menuLocationTitle
        diningHallName.textColor = UIColor.twilightBlue
        diningHallHours.textColor = UIColor.MenuItemGray
        clockIcon.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
//        tableView.addBorderTop(size: 1.2, color: .gray)
        
        //Auto-Layout using code. Please do it this way in your future code - Ayush
        greyBackground.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(27)
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        activityLevelBar.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(7)
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        diningHallName.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview()
        }
        
        diningHallHours.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(diningHallName.snp.height) // 17?
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.height.greaterThanOrEqualTo(126)
            make.bottom.equalToSuperview().offset(42)
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        // Ayush please fix these constraints, it only looks good on a 8+ rn
        clockIcon.snp.makeConstraints{ (make) -> Void in
            make.height.width.equalTo(14)
            make.top.equalToSuperview().offset(73)
            make.left.equalToSuperview().offset(237)
            make.right.equalToSuperview().offset(-173)
        }
        
        menuCardView.clipsToBounds = true
        
    }
}
