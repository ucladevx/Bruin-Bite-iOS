//
// Created by dc on 2019-04-13.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuDetailViewController: UITableViewController{
    var location: String?
    var items: [Item]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = items?[indexPath.row]
        cell.textLabel?.text = item?.name
        return cell
    }
}
