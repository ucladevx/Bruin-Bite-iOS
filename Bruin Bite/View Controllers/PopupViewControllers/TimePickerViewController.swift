//
//  TimePickerViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/24/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

struct timeData{
    var text: String
    var isSelected: Bool
}

var chosen = [String]()

protocol TimePickerViewControllerDelegate {
    func didConfirm(withChoices: String)
}

class TimePickerViewController: UIViewController {
    
    var delegate: TimePickerViewControllerDelegate? = nil
    
    var times: [timeData] = []
//    var times: [String] = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "10:45", "12:00", "12:15"]
    let breakfast_times = ["07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00"]
    let lunch_times = ["11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "1:00", "1:15", "1:30", "1:45", "2:00", "2:15", "2:30","2:45", "3:00"]
    let dinner_times = ["4:15", "4:30", "4:45", "5:00", "5:15", "5:30", "5:45", "6:00", "6:15", "6:30", "6:45", "7:00", "7:15", "7:30","7:45", "8:00"]
    let late_times = ["9:00", "9:15", "9:30", "9:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15","12:30", "12:45"]

  @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func backgroundButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
    times = [timeData]()
        //format the popup view
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    if(MAIN_USER.accessUserInfo(type: "period") == "BR") {
        for i in 0...15
        {
            var time = timeData(text: breakfast_times[i], isSelected: false)
            times.append(time)
        }
    } else if(MAIN_USER.accessUserInfo(type: "period") == "LU") {
        for j in 0...15
        {
            var time = timeData(text: lunch_times[j], isSelected: false)
            times.append(time)
        }
    } else if(MAIN_USER.accessUserInfo(type: "period") == "DI") {
        for d in 0...15
        {
            var time = timeData(text: dinner_times[d], isSelected: false)
            times.append(time)
        }
    } else if(MAIN_USER.accessUserInfo(type: "period") == "LN") {
        for e in 0...15
        {
            var time = timeData(text: late_times[e], isSelected: false)
            times.append(time)
        }
    } else {
        Logger.log("No meal period selected", withLevel: .warning)
    }
    
    }
  
  @IBAction func completeActionButton(_ sender: Any) {
    var temp = [String]()
    var chosenString = ""
    if(times.isEmpty == false) {
        for i in 0...15 {
            if(times[i].isSelected) {
                if(MAIN_USER.accessUserInfo(type: "period") != "BR") {
                    let tempor = timeForm(time: times[i].text) + ":00"
                    temp.append(tempor)
                } else {
                    let tempor2 = times[i].text + ":00"
                temp.append(tempor2)
                }
                chosenString += times[i].text + ", "
            }
        }
        chosen = temp
        chosenString = chosenString.isEmpty ? "" : String(chosenString[chosenString.startIndex..<chosenString.index(chosenString.endIndex, offsetBy: -2)])
        self.delegate?.didConfirm(withChoices: chosenString)
    }
        dismiss(animated: true, completion: nil)
  }
}

extension TimePickerViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "time", for: indexPath) as! TimePickerCollectionViewCell
        
        cell.timeLabel.layer.cornerRadius = 15
        cell.timeLabel.clipsToBounds = true
        cell.timeLabel.backgroundColor = UIColor.clear
        cell.timeLabel.textColor = UIColor.warmGrey
        
        cell.timeLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        cell.timeLabel.text = times[indexPath.row].text
        return cell
    }
}

extension TimePickerViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.log("tapped", withLevel: .debug)
        let cell = collectionView.cellForItem(at: indexPath) as! TimePickerCollectionViewCell
        
        if times[indexPath.row].isSelected == false{
            
            cell.timeLabel.backgroundColor = UIColor.twilightBlue
            cell.timeLabel.textColor = UIColor.white
            
            times[indexPath.row].isSelected = true
        }
        else{
            cell.timeLabel.backgroundColor = UIColor.clear
            cell.timeLabel.textColor = UIColor.warmGrey
            
            times[indexPath.row].isSelected = false
        }
    }
}
