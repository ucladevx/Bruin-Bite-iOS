//
//  MatchTableViewCell.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 2/26/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MealPeriodLabel: UILabel!
    @IBOutlet weak var MealTimeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
