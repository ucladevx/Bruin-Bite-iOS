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

class TimePickerViewController: UIViewController {
    
    var times: [timeData] = []
//    var times: [String] = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "10:45", "12:00", "12:15"]
    

  @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func backgroundButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
    
        //format the popup view
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    
        for i in 1...16
        {
            var time = timeData(text: String(1000 + i), isSelected: false)
            times.append(time)
        }
    
    }
  
  @IBAction func completeActionButton(_ sender: Any) {
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
