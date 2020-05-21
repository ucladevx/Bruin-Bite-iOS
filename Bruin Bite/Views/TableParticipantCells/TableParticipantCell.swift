//
//  TableParticipantCell.swift
//  Bruin Bite
//
//  Created by Abhishek Marda on 5/9/20.
//  Copyright © 2020 Dont Eat Alone. All rights reserved.
//

import UIKit

class TableParticipantCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var creatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = containerView.frame.size.height/6
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
