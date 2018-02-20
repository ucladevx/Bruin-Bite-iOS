//
//  SecondViewController.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, WeekViewTappedDelegate  {
    @IBOutlet var circleLabel: UILabel!
    @IBOutlet var dayBtns: [WeekView]!
    @IBOutlet var circleSelect: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dayBtns.count)
        circleSelect.backgroundColor = UIColor.red
        circleLabel.textColor = UIColor.blue
        
        for i in 0 ..< dayBtns.count{
            let date = Date().addingTimeInterval(TimeInterval(86400 * (i-1)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            if(i==1){
                circleSelect.frame = CGRect(x:27+50*i, y:60, width: 20, height:20)
                circleLabel.frame=CGRect(x:28+50*i, y:60, width: 20, height:20)
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
    }
    
    func daySelected(_ selectedLabelText: String) {
        print(selectedLabelText)
        for i in 0 ..< dayBtns.count{
            if(selectedLabelText == dayBtns[i].dateLbl.text){
                circleSelect.frame = CGRect(x:27+50*i, y:60, width: 20, height:20)
                circleLabel.frame=CGRect(x:28+50*i, y:60, width: 20, height:20)
                circleLabel.text = selectedLabelText
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

