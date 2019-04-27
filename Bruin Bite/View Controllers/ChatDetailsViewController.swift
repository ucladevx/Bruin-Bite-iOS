//
//  ChatDetailsViewController.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 4/25/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class ChatDetailsViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var diningHallLabel: UILabel!
    @IBOutlet weak var mealPeriodLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var day: String?
    var diningHall: String?
    var mealPeriod: String?
    var time: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayLabel.text = day
        diningHallLabel.text = diningHall
        mealPeriodLabel.text = mealPeriod
        timeLabel.text = time
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
