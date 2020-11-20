//
//  Language.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import Foundation

enum Language: String {
    
    case english
    case german
    case hindi
    case italian
    case japanese
    case russian
    
    var code: String {
        switch self {
        case .english: return "en"
        case .german: return "de"
        case .hindi: return "hi"
        case .italian: return "it"
        case .japanese: return "ja"
        case .russian: return "ru"
        }
    }
}
