//
//  UserSettingsProtocol.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 25.11.20.
//

import Foundation

protocol UserSettingsProtocol {
    var unit: Unit { get set }
    var language: Language { get set }
}
