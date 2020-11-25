//
//  LanguageTableViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import UIKit

final class LanguageTableViewController: UITableViewController {
    
    public var userSettings: UserSettingsProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCurrentLanguage()
    }
    
    private func selectCurrentLanguage() {
        guard let selectedLanguageIndex = Language.allCases.firstIndex(of: userSettings.language) else {
            return
        }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: selectedLanguageIndex, section: 0)
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.tableView.delegate?.tableView?(self.tableView, didSelectRowAt: indexPath)
        }
    }
    
    
}

// MARK: - Table view data source
extension LanguageTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Language.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath)
        cell.textLabel?.text = Language.allCases[indexPath.row].rawValue.capitalized
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        if Language.allCases.indices.contains(indexPath.row) {
            userSettings.language = Language.allCases[indexPath.row]
        } else {
            assertionFailure()
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
