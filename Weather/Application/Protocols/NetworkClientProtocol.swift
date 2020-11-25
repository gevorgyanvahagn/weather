//
//  NetworkClientProtocol.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 26.11.20.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ builder: URLBuilder, completion: ((Result<T, Error>) -> Void)?)
}
