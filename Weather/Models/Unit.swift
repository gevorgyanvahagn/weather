//
//  Unit.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import Foundation

enum Unit: String, CaseIterable {
    case metric = "Metric"
    case imperial = "Imperial"
    
    var intValue: Int {
        return Unit.allCases.firstIndex(of: self) ?? 0
    }
    
    static func unit(at index: Int) -> Unit? {
        if Unit.allCases.indices.contains(index) {
            return Unit.allCases[index]
        }
        return nil
    }
    
    var unitTemperature: UnitTemperature {
        switch self {
        case .imperial:
            return .fahrenheit
        case .metric:
            return .celsius
        }
    }
}
