//
//  PreferenceViewController.swift
//  Bruin Bite
//
//  Created by Hirday Gupta on 4/13/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import UIKit

class PreferenceViewController: UIViewController {
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var DayBtn: UIButton!
    @IBOutlet weak var DiningHallBtn: UIButton!
    @IBOutlet weak var MealPeriodBtn: UIButton!
    @IBOutlet weak var TimeBtn: UIButton!
    @IBOutlet weak var MatchMeBtn: UIButton!
    
    let DEFAULT_TEXT: [String:String] = [
        "Day": "What day are you free?",
        "DiningHall": "Which one's your favorite?",
        "MealPeriod": "When would you like to eat?",
        "Time": "Starting time?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // formatting top bar
        TopView.backgroundColor = UIColor.twilightBlue
        
        // setting title texts for buttons
        DayBtn.setTitle(DEFAULT_TEXT["Day"], for: .normal)
        DiningHallBtn.setTitle(DEFAULT_TEXT["DiningHall"], for: .normal)
        MealPeriodBtn.setTitle(DEFAULT_TEXT["MealPeriod"], for: .normal)
        TimeBtn.setTitle(DEFAULT_TEXT["Time"], for: .normal)
    }
    
    
    
    
    
}
