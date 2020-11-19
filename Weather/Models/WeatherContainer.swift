//
//  WeatherContainer.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct WeatherContainer<T: Codable>: Codable {
    let code: String?
    let message, count: Int?
    let list: [T]?
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list
        case city
    }
}
