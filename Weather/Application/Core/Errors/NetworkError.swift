//
//  NetworkError.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest(reason: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidRequest(let reason):
            return reason
        }
    }
}
