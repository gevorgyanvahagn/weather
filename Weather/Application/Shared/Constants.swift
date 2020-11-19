//
//  Constants.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

struct Constants {
    
    // TODO: - All secrets should be saved in .env and removed from git history.
    struct Secrets {
        static let appId = "f2440bae516427dc5284235fcb321e65"
    }
    
    struct Links {
        static let endpoint = URL(string: "https://api.openweathermap.org/data/2.5")!
    }
    
    struct Values {
        static let filterMaxPrice = 100000
    }
}
