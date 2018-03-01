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
    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundView.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        circleSelect.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        circleLabel.textColor = UIColor.black
        bezelView.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        bezelLabel.textColor = UIColor.black
        bezelView.frame = CGRect(x: 12.5, y: 62, width: 87.5, height: 40)
        bezelLabel.frame = CGRect(x: 24, y: 72, width: 80, height: 20)
        
        for i in 0 ..< dayBtns.count{
            let date = Date().addingTimeInterval(TimeInterval(86400 * (i-1)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            if(i==1){
                circleSelect.frame = CGRect(x:25+50*i, y:38, width: 24, height:24)
                circleLabel.text = dateFormatter.string(from: date)
                if(Int(circleLabel.text!)! < 10){
                    circleLabel.frame=CGRect(x:33+50*i, y:40, width: 20, height:20)
                }
                else{
                    circleLabel.frame=CGRect(x:28+50*i, y:40, width: 20, height:20)
                }
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
                circleLabel.text = selectedLabelText
                circleSelect.frame = CGRect(x:25+50*i, y:38, width: 24, height:24)
                if(Int(selectedLabelText)! < 10){
                    circleLabel.frame=CGRect(x:33+50*i, y:40, width: 20, height:20)
                }
                else{
                    circleLabel.frame=CGRect(x:28+50*i, y:40, width: 20, height:20)
                }
            }
        }
    }
    
    func timeSelected(_ selectedLabelText: String){
        bezelLabel.text = selectedLabelText
        if(selectedLabelText == "Breakfast"){
            bezelView.frame = CGRect(x: 12.5, y: 62, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 24, y: 72, width: 80, height: 20)
        }
        if(selectedLabelText == "Lunch"){
            bezelView.frame = CGRect(x: 100, y: 62, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 122.5, y: 72, width: 70, height: 20)
        }
        if(selectedLabelText == "Dinner"){
            bezelView.frame = CGRect(x: 187.5, y: 62, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 210, y: 72, width: 70, height: 20)
        }
        if(selectedLabelText == "Night"){
            bezelView.frame = CGRect(x: 275, y: 62, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 301.5, y: 72, width: 65, height: 20)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

