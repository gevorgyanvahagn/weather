//
//  Wind.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct Wind: Codable {
    let speed: Double?
    let degree: Int?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}
