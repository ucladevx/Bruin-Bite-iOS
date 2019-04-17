//
// Created by dc on 2019-04-13.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuDetailViewController: UITableViewController{
    var location: String = ""
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
