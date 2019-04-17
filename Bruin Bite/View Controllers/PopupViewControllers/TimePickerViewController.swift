//
//  TimePickerViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/24/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

struct timeData{
    var date: Date
    var isSelected: Bool
}

var chosen = [String]()

protocol TimePickerViewControllerDelegate {
    func didConfirm(withChoices: [Date])
}

class TimePickerViewController: UIViewController {
    
    // INPUT:
    var chosen_meal_period: String? = nil
    var chosen_date: Date? = nil
    
    var delegate: TimePickerViewControllerDelegate? = nil
    
    var times: [timeData] = []
    
    private var breakfast_dates: [Date] {
        get {
            guard let chosen_date = chosen_date else {
                return []
            }
            let start_datetime = Date.breakfastStartTime(onDate: chosen_date)
            var dates = [start_datetime]
            for i in 1...15 {
                dates.append(Calendar.current.date(byAdding: .minute, value: i*15, to: start_datetime) ?? start_datetime)
            }
            return dates
        }
    }
    
    private var lunch_dates: [Date] {
        get {
            guard let chosen_date = chosen_date else {
                return []
            }
            let start_datetime = Date.lunchStartTime(onDate: chosen_date)
            var dates = [start_datetime]
            for i in 1...15 {
                dates.append(Calendar.current.date(byAdding: .minute, value: i*15, to: start_datetime) ?? start_datetime)
            }
            return dates
        }
    }
    
    private var dinner_dates: [Date] {
        get {
            guard let chosen_date = chosen_date else {
                return []
            }
            let start_datetime = Date.dinnerStartTime(onDate: chosen_date)
            var dates = [start_datetime]
            for i in 1...15 {
                dates.append(Calendar.current.date(byAdding: .minute, value: i*15, to: start_datetime) ?? start_datetime)
            }
            return dates
        }
    }

  @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func backgroundButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    times = [timeData]()
    popupView.layer.cornerRadius = 10
    popupView.layer.masksToBounds = true

    var selected_period_times = breakfast_dates
    switch chosen_meal_period {
    case "BR":
        selected_period_times = breakfast_dates
    case "LU":
        selected_period_times = lunch_dates
    case "DI":
        selected_period_times = dinner_dates
    default:
        selected_period_times = breakfast_dates
    }
    for i in 0...15 {
        let time = timeData(date: selected_period_times[i], isSelected: false)
        times.append(time)
    }
    }
  
  @IBAction func completeActionButton(_ sender: Any) {
    var selected_dates: [Date] = []
    for time in times {
        if !time.isSelected {
            continue
        }
        selected_dates.append(time.date)
    }
    delegate?.didConfirm(withChoices: selected_dates)
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
        cell.timeLabel.text = times[indexPath.row].date.hourMinuteDayString()
        return cell
    }
}

extension TimePickerViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
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
