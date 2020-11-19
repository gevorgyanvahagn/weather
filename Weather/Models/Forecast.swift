//
//  Forecast.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct Forecast: Codable {
    let date: Int?
    let main: WeatherMainInfo?
    let weather: [Weather]?
    let clouds: Cloud?
    let wind: Wind?
    let visibility: Int?
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case clouds
        case wind
        case visibility
    }
}
