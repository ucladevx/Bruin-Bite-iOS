//
// Created by dc on 2019-04-13.
// Copyright (c) 2019 Dont Eat Alone. All rights reserved.
//

import UIKit

class MenuDetailViewController: UITableViewController{
    var location: Location?
    var items: [Item]?
    var sectionedItems: [String: [Item]] = [:]

    var initDate = "1"
    var initMP = MealPeriod.breakfast
    var currDate = "1"
    var currMP = MealPeriod.breakfast

    var activityLevelData = [ActivityLevel]()
    var hoursData = [String: [Location: HallHours]]()

    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var activityLevelBar: ActivityLevelBar!
    @IBOutlet weak var diningHallHours: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location?.rawValue
        diningHallName.text = location?.rawValue

        if let locationRaw = location?.rawValue,
           let hall = Location(rawValue: locationRaw) {
            var hoursText = ""
            switch currMP {
            case .breakfast:
                hoursText = hoursData[currDate]?[hall]?.breakfast ?? ""
            case .lunch, .brunch:
                hoursText = hoursData[currDate]?[hall]?.lunch ?? ""
            case .dinner:
                hoursText = hoursData[currDate]?[hall]?.dinner ?? ""
            case .lateNight:
                hoursText = hoursData[currDate]?[hall]?.late_night ?? ""
            }
            diningHallHours.text? = hoursText
        } else {
            diningHallHours.text? = ""
        }

        let calendar = Calendar.current

        var dateComponents: DateComponents? = calendar.dateComponents([.hour, .minute, .second], from: Date())

        dateComponents?.day = Int(currDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"

        let date: Date? = calendar.date(from: dateComponents!)
        if let date = date {
            self.navigationItem.rightBarButtonItem?.title = dateFormatter.string(from: date)
        }

        tableView.register(MenuDetailSectionHeader.self,
                forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }

    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! MenuDetailSectionHeader
        view.title.text = Array(sectionedItems.keys)[section]

        return view
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

        //Activity Level Loading
        activityLevelBar.resizeToZero()
        activityLevelBar.percentage = CGFloat(0)
        for a in activityLevelData {
            if (a.isAvailable && location == a.location && currDate == initDate && currMP == initMP) {
                activityLevelBar.percentage = CGFloat(a.percent) / 100
            } else if (location == a.location) {
                activityLevelBar.percentage = CGFloat(0)
            }
        }
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            self.activityLevelBar.animateBar()
        }) { (_) in
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        let itemsInSection = getItems(in: indexPath.section)
        let item = itemsInSection?[indexPath.row]
        cell.textLabel?.text = item?.name
        cell.textLabel?.textColor = UIColor.MenuItemGray
        cell.textLabel?.font = UIFont.textStyle
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segueToItemDetailVC"?:
            if let indexPath = tableView.indexPathForSelectedRow {
                let itemsInSection = getItems(in: indexPath.section)
                let item = itemsInSection?[indexPath.row]
                let vc = segue.destination as! ItemDetailViewController
                vc.menuItem = item
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
