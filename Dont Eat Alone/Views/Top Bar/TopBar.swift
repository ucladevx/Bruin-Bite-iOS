//
//  TopBar.swift
//  Dont Eat Alone
//
//  Created by Arpit Jasapara on 3/3/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

@IBDesignable class TopBar: UIView, TimeViewTappedDelegate, WeekViewTappedDelegate {
    weak var parentVC: MenuVC?
    var circleLabel = UILabel()
    var dayBtns = [WeekView]()
    var circleSelect = ColoredCircle()
    var timeBtns = [TimeView]()
    var bezelView = ColoredBezel()
    var bezelLabel = UILabel()
    var brunch = false
    var morning = true
    var dinner = false
    var currDay = ""
    var currTime = MealPeriod.breakfast
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        circleSelect.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        circleLabel.textColor = UIColor.black
        bezelView.backgroundColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
        bezelLabel.textColor = UIColor.black
        bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
        bezelLabel.frame = CGRect(x: 12, y: 52, width: 80, height: 20)
        bezelLabel.text = "Breakfast"
        
        for i in 0 ..< 4{
            timeBtns.append(TimeView())
            self.addSubview(timeBtns[i])
            timeBtns[i].frame = CGRect(x: (Double)(i)*87.5, y:42, width:87.5, height: 40)
            timeBtns[i].timeLbl.frame = CGRect(x: 0, y: 10, width: 87.5, height: 20)
            timeBtns[i].setDelegateAndTap(self)
        }
        timeBtns[0].timeLbl.text = "Breakfast"
        timeBtns[1].timeLbl.text = "Lunch"
        timeBtns[2].timeLbl.text = "Dinner"
        timeBtns[3].timeLbl.text = "Night"
        
        for i in 0 ..< 7{
            dayBtns.append(WeekView())
            self.addSubview(dayBtns[i])
            dayBtns[i].frame = CGRect(x:(Double)(50*i), y:0, width: 50, height: 42)
            let date = Date().addingTimeInterval(TimeInterval(86400 * (i-1)))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            if(i==1){
                circleSelect.frame = CGRect(x:9+50*i, y:18, width: 24, height:24)
                circleLabel.text = dateFormatter.string(from: date)
                currDay = dateFormatter.string(from: date)
                if(Int(circleLabel.text!)! < 10){
                    circleLabel.frame=CGRect(x:17+50*i, y:20, width: 20, height:20)
                }
                else{
                    circleLabel.frame=CGRect(x:12+50*i, y:20, width: 20, height:20)
                }
            }
            dayBtns[i].dateLbl.frame = CGRect(x: 0, y: 20, width: 50, height: 20)
            dayBtns[i].dateLbl.text = dateFormatter.string(from: date)
            dayBtns[i].dateLbl.textAlignment = .center
            dateFormatter.dateFormat = "EEE"
            dayBtns[i].weekLbl.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            dayBtns[i].weekLbl.text = dateFormatter.string(from: date)
            if (i==1 && (dayBtns[i].weekLbl.text == "Sun" || dayBtns[i].weekLbl.text == "Sat")){
                brunch = true
                timeBtns[0].timeLbl.text = "Brunch"
                currTime = MealPeriod.brunch
                timeBtns[1].timeLbl.text = ""
                timeBtns[0].frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                timeBtns[1].frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                timeBtns[2].frame = CGRect(x: 131, y: 42, width: 87.5, height: 40)
                bezelLabel.text = "Brunch"
                bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                bezelLabel.frame = CGRect(x: 18.5, y: 52, width: 80, height: 20)
            }
            dayBtns[i].weekLbl.textAlignment = .center
            dayBtns[i].setDelegateAndTap(self)
        }
        circleLabel.font = circleLabel.font.withSize(15.0)
        bezelLabel.font = bezelLabel.font.withSize(15.0)
        self.addSubview(circleSelect)
        self.addSubview(circleLabel)
        self.addSubview(bezelView)
        self.addSubview(bezelLabel)
    }
    
    func daySelected(_ selectedLabelText: String, dayLabel: String) {
        currDay = selectedLabelText
        for i in 0 ..< dayBtns.count{
            if(selectedLabelText == dayBtns[i].dateLbl.text){
                if(dayLabel == "Sun" || dayLabel == "Sat"){
                    timeBtns[0].timeLbl.text = "Brunch"
                    timeBtns[1].timeLbl.text = ""
                    timeBtns[0].frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                    timeBtns[1].frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                    timeBtns[2].frame = CGRect(x: 131, y: 42, width: 87.5, height: 40)
                    if (!brunch && morning){
                        bezelLabel.text = "Brunch"
                        bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                        bezelLabel.frame = CGRect(x: 18.5, y: 52, width: 80, height: 20)
                    }
                    if (!brunch && dinner){
                        bezelView.frame = CGRect(x: 131, y: 42, width: 87.5, height: 40)
                        bezelLabel.frame = CGRect(x: 154, y: 52, width: 70, height: 20)
                    }
                    brunch = true
                    
                }
                else{
                    timeBtns[0].timeLbl.text = "Breakfast"
                    timeBtns[1].timeLbl.text = "Lunch"
                    timeBtns[0].frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                    timeBtns[1].frame = CGRect(x: 87.5, y: 42, width: 87.5, height: 40)
                    timeBtns[2].frame = CGRect(x: 175, y: 42, width: 87.5, height: 40)
                    if (brunch && morning){
                        bezelLabel.text = "Breakfast"
                        bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
                        bezelLabel.frame = CGRect(x: 12, y: 52, width: 80, height: 20)
                    }
                    if (brunch && dinner){
                        bezelView.frame = CGRect(x: 175, y: 42, width: 87.5, height: 40)
                        bezelLabel.frame = CGRect(x: 198, y: 52, width: 70, height: 20)
                    }
                    brunch = false
                }
                circleLabel.text = selectedLabelText
                circleSelect.frame = CGRect(x:12+50*i, y:18, width: 24, height:24)
                if(Int(selectedLabelText)! < 10){
                    circleLabel.frame=CGRect(x:19.5+(Double)(50*i), y:20, width: 20, height:20)
                }
                else{
                    circleLabel.frame=CGRect(x:15+50*i, y:20, width: 20, height:20)
                }
            }
        }
        parentVC?.updateData(currDay, mP: currTime)
    }
    
    func timeSelected(_ selectedLabelText: String){
        bezelLabel.text = selectedLabelText
        dinner = false
        if(selectedLabelText == "Breakfast"){
            morning = true
            bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 12, y: 52, width: 80, height: 20)
            currTime = MealPeriod.breakfast
        }
        if(selectedLabelText == "Brunch"){
            morning = true
            bezelView.frame = CGRect(x: 0, y: 42, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 18.5, y: 52, width: 80, height: 20)
            currTime = MealPeriod.brunch
        }
        if(selectedLabelText == "Lunch"){
            morning = true
            bezelView.frame = CGRect(x: 87.5, y: 42, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 110, y: 52, width: 70, height: 20)
            currTime = MealPeriod.lunch
        }
        if(selectedLabelText == "Dinner"){
            morning = false
            dinner = true
            currTime = MealPeriod.dinner
            if (brunch){
                bezelView.frame = CGRect(x: 131, y: 42, width: 87.5, height: 40)
                bezelLabel.frame = CGRect(x: 154, y: 52, width: 70, height: 20)
            }
            else{
                bezelView.frame = CGRect(x: 175, y: 42, width: 87.5, height: 40)
                bezelLabel.frame = CGRect(x: 198, y: 52, width: 70, height: 20)
            }
        }
        if(selectedLabelText == "Night"){
            morning = false
            currTime = MealPeriod.lateNight
            bezelView.frame = CGRect(x: 262.5, y: 42, width: 87.5, height: 40)
            bezelLabel.frame = CGRect(x: 289, y: 52, width: 65, height: 20)
        }
        parentVC?.updateData(currDay, mP: currTime)
    }
}
