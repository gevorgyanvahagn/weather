//
//  SettingsViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak private var unitSegmentedController: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        unitSegmentedController.selectedSegmentIndex = UserSettings.unit.intValue
    }

    @IBAction private func segmentedControllerValueDidChange(_ sender: UISegmentedControl) {
        if let unit = Unit.unit(at: sender.selectedSegmentIndex) {
            UserSettings.unit = unit
        }
    }
}
