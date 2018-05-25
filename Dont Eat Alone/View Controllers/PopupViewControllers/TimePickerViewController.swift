//
//  TimePickerViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 5/24/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    var times: [String] = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "10:45", "12:00", "12:15"]
    

  @IBOutlet weak var popupView: UIView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        //format the popup view
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
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
        return cell
    }
}

extension TimePickerViewController: UICollectionViewDelegateFlowLayout{
    
}
