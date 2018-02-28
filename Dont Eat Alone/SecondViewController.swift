//
//  SecondViewController.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, TimeViewTappedDelegate, WeekViewTappedDelegate  {
    @IBOutlet var circleLabel: UILabel!
    @IBOutlet var dayBtns: [WeekView]!
    @IBOutlet var circleSelect: UIView!
    @IBOutlet var timeBtns: [TimeView]!
    @IBOutlet var bezelView: UIView!
    @IBOutlet var bezelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circleSelect.backgroundColor = UIColor.red
        circleLabel.textColor = UIColor.blue
        bezelView.backgroundColor = UIColor.red
        bezelLabel.textColor = UIColor.blue
        bezelView.frame = CGRect(x: 12.5, y: 65, width: 87.5, height: 40)
        bezelLabel.frame = CGRect(x: 20, y: 75, width: 80, height: 20)
        
        for i in 0 ..< dayBtns.count{
            let date = Date().addingTimeInterval(TimeInterval(86400 * (i-1)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            if(i==1){
                circleSelect.frame = CGRect(x:27+50*i, y:45, width: 20, height:20)
                circleLabel.frame=CGRect(x:28+50*i, y:45, width: 20, height:20)
                circleLabel.text = dateFormatter.string(from: date)
            }
            dayBtns[i].dateLbl.frame = CGRect(x: 0, y: 20, width: 50, height: 20)
            dayBtns[i].dateLbl.text = dateFormatter.string(from: date)
            dayBtns[i].dateLbl.textAlignment = .center
            dateFormatter.dateFormat = "EEE"
            dayBtns[i].weekLbl.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            dayBtns[i].weekLbl.text = dateFormatter.string(from: date)
            dayBtns[i].weekLbl.textAlignment = .center
            dayBtns[i].setDelegateAndTap(self)
        }
        for i in 0 ..< timeBtns.count{
            timeBtns[i].timeLbl.frame = CGRect(x: 0, y: 10, width: 87.5, height: 20)
            timeBtns[i].setDelegateAndTap(self)
        }
        timeBtns[0].timeLbl.text = "Breakfast"
        timeBtns[1].timeLbl.text = "Lunch"
        timeBtns[2].timeLbl.text = "Dinner"
        timeBtns[3].timeLbl.text = "Night"
        
        
    }
    
    func daySelected(_ selectedLabelText: String) {
        for i in 0 ..< dayBtns.count{
            if(selectedLabelText == dayBtns[i].dateLbl.text){
                circleSelect.frame = CGRect(x:27+50*i, y:45, width: 20, height:20)
                circleLabel.frame=CGRect(x:28+50*i, y:45, width: 20, height:20)
                circleLabel.text = selectedLabelText
            }
        }
    }
    
    func timeSelected(_ selectedLabelText: String){
        bezelLabel.text = selectedLabelText
        if(selectedLabelText == "Breakfast"){
            bezelView.frame = CGRect(x: 12.5, y: 65, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 20, y: 75, width: 80, height: 20)
        }
        if(selectedLabelText == "Lunch"){
            bezelView.frame = CGRect(x: 100, y: 65, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 117.5, y: 75, width: 70, height: 20)
        }
        if(selectedLabelText == "Dinner"){
            bezelView.frame = CGRect(x: 187.5, y: 65, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 205, y: 75, width: 70, height: 20)
        }
        if(selectedLabelText == "Night"){
            bezelView.frame = CGRect(x: 275, y: 65, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 295.5, y: 75, width: 65, height: 20)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

