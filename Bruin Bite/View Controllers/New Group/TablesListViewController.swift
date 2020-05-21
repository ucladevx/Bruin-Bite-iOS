//
//  TablesListViewController.swift
//  Bruin Bite
//
//  Created by Abhishek Marda on 5/16/20.
//  Copyright © 2020 Dont Eat Alone. All rights reserved.
//

import UIKit

class TablesListViewController: UIViewController {
    @IBOutlet weak var ListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTable.delegate = self
        ListTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowJoinTableVC"{
            //prepare the participants array using API call
        }
    }
}

extension TablesListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowJoinTableVC", sender: nil)
        
    }
    
}

extension TablesListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}

