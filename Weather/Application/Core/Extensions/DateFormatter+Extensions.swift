//
//  DateFormatter+Extensions.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation

extension DateFormatter {
    static let globalHourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()
}
