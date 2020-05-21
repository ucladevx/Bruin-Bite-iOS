//
//  JoinTableViewController.swift
//  Bruin Bite
//
//  Created by Abhishek Marda on 5/9/20.
//  Copyright © 2020 Dont Eat Alone. All rights reserved.
//

import UIKit

struct TableParticipant {
    let name : String
    let isCreator : Bool
    let profilePicture : UIImage
}

class JoinTableViewController: UIViewController {

    @IBOutlet weak var ParticipantsTable: UITableView!
    
    //during segue to this view controller, the "participant" array will have to be updated in the prepare function
    var participants : [TableParticipant] = [
        TableParticipant(name: "Abhishek", isCreator: true, profilePicture: #imageLiteral(resourceName: "josie")),
        TableParticipant(name: "Jaykanth", isCreator: false, profilePicture: #imageLiteral(resourceName: "Paw")),
        TableParticipant(name: "Hirday", isCreator: false, profilePicture: #imageLiteral(resourceName: "Logo")),
        TableParticipant(name: "Kameron", isCreator: false, profilePicture: #imageLiteral(resourceName: "SplahLogo")),
        TableParticipant(name: "Katie", isCreator: false, profilePicture: #imageLiteral(resourceName: "NextArrow"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ParticipantsTable.delegate = self
        ParticipantsTable.dataSource = self
        
        ParticipantsTable.register(UINib(nibName: "TableParticipantCell", bundle: nil), forCellReuseIdentifier: "JoinTableCell")

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

}

extension JoinTableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoinTableCell", for: indexPath) as! TableParticipantCell
        
        cell.NameLabel.text = participants[indexPath.row].name
        if !participants[indexPath.row].isCreator{
            cell.creatorLabel.text = ""
        }
        cell.containerView.frame.size.height = tableView.frame.size.height/2
        cell.profilePic.image = participants[indexPath.row].profilePicture
        return cell
    }
    
    
}

extension JoinTableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // code to perform segue upon selection of the table join
    }
}
