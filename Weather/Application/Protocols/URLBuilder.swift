//
//  URLBuilder.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 26.11.20.
//

import Foundation
import Alamofire

protocol URLBuilder: URLConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [HTTPHeader] { get }
    var parameters: Parameters { get }
}
