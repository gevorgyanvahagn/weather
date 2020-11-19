//
//  City.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct City: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
