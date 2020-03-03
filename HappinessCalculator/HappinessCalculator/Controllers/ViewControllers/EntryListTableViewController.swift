//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Aaron Prestidge on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var averageHappiness: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EntryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryCellTableViewCell else {return UITableViewCell()}
        let entry = EntryController.entries[indexPath.row]
        cell.setEntry(entry: entry, averageHappiness: 0)
        
        cell.delegate = self
        
        return cell
    }
    
    func updateAverageHappiness() {
        var totalHappiness = 0
        for entry in EntryController.entries {
            if entry.isIncluded {
            totalHappiness += entry.happiness
            }
        }
        averageHappiness = totalHappiness / EntryController.entries.count
    }

}//END OF CLASS
extension EntryListTableViewController: EntryTableViewCellDelegate {
    func switchToggledOnCell(cell: EntryCellTableViewCell) {
        guard let entry = cell.entry else {return}
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
    }
    
    
}
