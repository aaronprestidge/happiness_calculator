//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Aaron Prestidge on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit
//Declaring a protocol and allowing it to use class le
protocol EntryTableViewCellDelegate: class {
    //creating a job that the tableViewCell (boss) can tell our delegate to carry out:
    func switchToggledOnCell(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - PROPERTIES
    var entry: Entry?
    
    //Create the delegate and specifying the type to be of EntryTableViewCellDelegate:
    weak var delegate: EntryTableViewCellDelegate?
    
    
    //MARK: - HELPER FUNCTIONS
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        createObserver()
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver() {
        //With the observer created, once triggered, the observer executes the following recalculation:
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateHappiness), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification:  NSNotification) {
        guard let averageHappiness = notification.object as? Int else {return}
        updateUI(averageHappiness: averageHappiness)
    }

    @IBAction func toggledIsIncluded(_ sender: Any) {
        //Passing information to the delegate - which tells the delegate what to do.
        delegate?.switchToggledOnCell(cell: self)
    }
    
}
