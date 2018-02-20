//
//  SecondViewController.swift
//  Dont Eat Alone
//
//  Created by Ashwin Vivek on 1/27/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, WeekViewTappedDelegate  {
    @IBOutlet var dayBtns: [WeekView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dayBtns.count)
        
        for i in 0 ..< dayBtns.count{
            let date = Date().addingTimeInterval(TimeInterval(86400 * (i-1)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            print(dateFormatter.string(from: date))
            dayBtns[i].dateLbl.frame = CGRect(x: 0, y: 70, width: 50, height: 30)
            dayBtns[i].dateLbl.text = dateFormatter.string(from: date)
            dayBtns[i].dateLbl.textAlignment = .center
            dateFormatter.dateFormat = "EEE"
            dayBtns[i].weekLbl.frame = CGRect(x: 0, y: 30, width: 50, height: 30)
            dayBtns[i].weekLbl.text = dateFormatter.string(from: date)
            dayBtns[i].weekLbl.textAlignment = .center
            dayBtns[i].setDelegateAndTap(self)
        }
    }
    
    func daySelected(_ selectedLabelText: String) {
        print(selectedLabelText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

