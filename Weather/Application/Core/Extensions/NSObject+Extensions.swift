//
//  NSObject+Extensions.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
