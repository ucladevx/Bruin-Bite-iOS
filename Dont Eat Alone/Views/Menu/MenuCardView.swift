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
    
    @IBOutlet weak var menuCardView: UIView!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diningHallName: UILabel!
    
    var data: [Item]
    weak var parentVC: MenuVC?
    let separator = UIView() //(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
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
        self.menuCardView.addSubview(self.activityLevelBar)
        
        separator.backgroundColor = .purple
        self.menuCardView.addSubview(self.separator)
        
        menuCardView.addSubview(diningHallName)
        // ?? clear makes background white but white makes background gray
        menuCardView.backgroundColor = .clear
        tableView.addBorderTop(size: 1.2, color: .white)
        
        diningHallName.font = UIFont.signUpTextFont
        diningHallName.textColor = UIColor.twilightBlue
        
        //Auto-Layout using code. Please do it this way in your future code - Ayush
        separator.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(57)
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        activityLevelBar.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(7)
            make.top.equalToSuperview().offset(57) //30
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        diningHallName.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(71) //44
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(135)
            make.top.equalToSuperview().offset(100)
            //make.top.equal activityLevelBar offset(56)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        
        menuCardView.clipsToBounds = true
        
    }
}
