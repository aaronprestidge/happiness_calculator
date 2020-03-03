//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Aaron Prestidge on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol EntryTableViewCellDelegate: class {
    func switchToggledOnCell(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - PROPERTIES
    var entry: Entry?
    weak var delegate: EntryTableViewCellDelegate?
    
    
    //MARK: - HELPER FUNCTIONS
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }

    @IBAction func toggledIsIncluded(_ sender: Any) {
        delegate?.switchToggledOnCell(cell: self)
    }
    
}