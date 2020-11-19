//
//  WeatherMainInfo.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct WeatherMainInfo: Codable {
    let temperature: Double?
    let feelsLike: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
    let pressure: Int?
    let seaLevel: Int?
    let groundLevel: Int?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity
    }
}
