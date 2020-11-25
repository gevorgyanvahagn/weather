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
    public var userSettins: UserSettings!

    override func viewDidLoad() {
        super.viewDidLoad()
        unitSegmentedController.selectedSegmentIndex = userSettins.unit.intValue
        setSelectedLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedLanguage), name: NSNotification.Name.userSettingsLanguageChanged, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLanguageTableViewController" {
            if let viewController = segue.destination as? LanguageTableViewController {
                viewController.userSettings = UserSettings()
            }
        }
    }

    @IBAction private func segmentedControllerValueDidChange(_ sender: UISegmentedControl) {
        if let unit = Unit.unit(at: sender.selectedSegmentIndex) {
            userSettins.unit = unit
        } else {
            assertionFailure()
        }
    }
    
    @objc private func setSelectedLanguage() {
        selectedLanguageLabel.text = userSettins.language.rawValue.capitalized
    }
}
