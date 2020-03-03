//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Aaron Prestidge on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit
//Assigning a name to our notification that can be used across the app - aka "GLobal Property"
let notificationKey = Notification.Name(rawValue: "didChangeHappiness")

class EntryListTableViewController: UITableViewController {

    var averageHappiness: Int = 0 {
        //PROPERTY OBSERVER:
        didSet {
            //runs the following each time averageHappiness is set or reset:
            NotificationCenter.default.post(name: notificationKey, object: self.averageHappiness)
        }
    }
    
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
        //Taking thecell property from the EntryController and setting it equal to itself: Assigning the delegate
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

//Extending our class to include the following instructions:
extension EntryListTableViewController: EntryTableViewCellDelegate {
    //creating the function to be carried out by the delegate:
    func switchToggledOnCell(cell: EntryCellTableViewCell) {
        guard let entry = cell.entry else {return}
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
    }
    
    
}
