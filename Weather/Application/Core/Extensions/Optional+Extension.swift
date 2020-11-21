//
//  Optional+Extension.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import Foundation

extension Optional {
    var isNone: Bool {
        return self == nil
    }
    
    var isSome: Bool {
        return self != nil
    }
}
