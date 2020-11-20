//
//  System.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import Foundation

struct System: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Date?
    let sunset: Date?
}
