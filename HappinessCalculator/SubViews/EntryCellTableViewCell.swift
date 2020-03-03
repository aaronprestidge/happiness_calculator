//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Aaron Prestidge on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryCellTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - PROPERTIES
    var entry: Entry?
    
    //MARK: - HELPER FUNCTIONS
    func setEntry(entry: Entry, averagrHappiness: Int) {
        self.entry = entry
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabledSwitch.isOn = entry.isIncluded
        
        //update higher or lower after notifications
        }
    
    
    
}
