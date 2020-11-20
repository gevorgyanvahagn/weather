//
//  SettingsViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    @IBOutlet weak private var unitSegmentedController: UISegmentedControl!
    @IBOutlet weak private var selectedLanguageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        unitSegmentedController.selectedSegmentIndex = UserSettings.unit.intValue
        setSelectedLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedLanguage), name: NSNotification.Name.userSettingsLanguageChanged, object: nil)
    }

    @IBAction private func segmentedControllerValueDidChange(_ sender: UISegmentedControl) {
        if let unit = Unit.unit(at: sender.selectedSegmentIndex) {
            UserSettings.unit = unit
        }
    }
    
    @objc private func setSelectedLanguage() {
        selectedLanguageLabel.text = UserSettings.language.rawValue.capitalized
    }
}
