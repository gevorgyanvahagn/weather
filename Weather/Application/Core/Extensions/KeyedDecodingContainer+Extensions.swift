//
//  KeyedDecodingContainer+Extensions.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeDate(forKey key: KeyedDecodingContainer.Key, dateFormatter: DateFormatter) throws -> Date? {
        do {
            if let dateString = try self.decodeIfPresent(String.self, forKey: key) {
                return(dateFormatter.date(from: dateString))
            } else {
                return nil
            }
        } catch let error {
            throw(error)
        }
    }
    
    func decodeIfPresent(_ type: Date.Type, forKey key: Self.Key) throws -> Date? {
        do {
            if let timeInterval = try self.decodeIfPresent(Int.self, forKey: key) {
                return(Date(timeIntervalSince1970: TimeInterval(timeInterval)))
            } else {
                return nil
            }
        } catch let error {
            throw(error)
        }
    }
}
