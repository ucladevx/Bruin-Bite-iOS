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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    @IBOutlet weak var tableView: UITableView!
    
    //for using custom view in code
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }

    //for using custom view in Interface Builder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        tableView.delegate = self
//        tableView.dataSource = self
        commonInit()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TAP...")
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
        
        let screenWidth = UIScreen.main.bounds.size.width
        menuCardView.frame = CGRect(x: (screenWidth/2) - (0.85*screenWidth/2), y: 0, width: 0.85*screenWidth, height: 0.56*screenWidth)
        menuCardView.center.x = self.center.x
        menuCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        menuCardView.backgroundColor = .gray
        menuCardView.layer.cornerRadius = 8
        
        let convert_bar_bounds = menuCardView.convert(activityLevelBar.frame, from: menuCardView)
        
        let bar_height = activityLevelBar.frame.height
       
        activityLevelBar.frame = CGRect(x: activityLevelBar.bounds.origin.x-10, y: activityLevelBar.bounds.origin.y-15, width: menuCardView.bounds.width, height: bar_height)
        
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
