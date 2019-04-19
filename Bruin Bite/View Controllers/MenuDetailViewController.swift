//
// Created by dc on 2019-04-13.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuDetailViewController: UITableViewController{
    var location: String?
    var items: [Item]?
    var sectionedItems: [String: [Item]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

        if let items = items, items.count > 0 {
            let filteredItems = items.filter { item in
                item.subLocation != nil
            }
            for item in filteredItems {
                sectionedItems[item.subLocation!, default: []].append(item)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedItems.count
    }

    func getItems(in section: Int) -> [Item]? {
        return sectionedItems[Array(sectionedItems.keys)[section]]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemsInSection: [Item]? = getItems(in: section)
        return itemsInSection?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(sectionedItems.keys)[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        let itemsInSection = getItems(in: indexPath.section)

        let item = itemsInSection?[indexPath.row]
        cell.textLabel?.text = item?.name
        return cell
    }
}
