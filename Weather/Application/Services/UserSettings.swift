//
//  UserSettings.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import Foundation

struct UserSettings: UserSettingsProtocol {
    
    private let unitKey = "userSettingsUnitKey"
    private let languageKey = "userSettingsLanguageKey"
    
    var unit: Unit {
        get {
            if let unit = UserDefaults.standard.string(forKey: unitKey) {
                return Unit(rawValue: unit) ?? .metric
            }
            return .metric
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: unitKey)
            NotificationCenter.default.post(name: NSNotification.Name.userSettingsUnitChanged, object: nil)
        }
    }
    
    var language: Language {
        get {
            if let language = UserDefaults.standard.string(forKey: languageKey) {
                return Language(rawValue: language) ?? .english
            }
            return .english
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: languageKey)
            NotificationCenter.default.post(name: NSNotification.Name.userSettingsLanguageChanged, object: nil)
        }
    }
}
