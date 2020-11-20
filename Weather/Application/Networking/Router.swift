//
//  Router.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import Foundation
import Alamofire

enum Router: URLConvertible {
    
    case fiveDayWeatherForecast(countryCode: String)
    
    var baseURL: URL {
        return Constants.Links.endpoint
    }
    
    var method: HTTPMethod {
        switch self {
        case .fiveDayWeatherForecast: return .get
        }
    }
    
    var path: String {
        switch self {
        case .fiveDayWeatherForecast: return "forecast"
        }
    }
    
    var headers: [HTTPHeader] {
        switch self {
        case .fiveDayWeatherForecast:
            return []
            
        }
    }
    var parameters: Parameters {
        switch self {
        case .fiveDayWeatherForecast(let countryCode):
            return ["q": countryCode, "appid": Constants.Secrets.appId]
        }
    }
    
    func asURL() throws -> URL {
        return baseURL.appendingPathComponent(path)
    }
    
    func request<T: Decodable>(completion: ((Result<T, Error>) -> Void)? = nil) {
        
        guard let url = try? self.asURL() else {
            assertionFailure()
            // TODO: - Add localisation
            completion?(.failure(NetworkError.invalidRequest(reason: "Data missing")))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders(headers))
            .validate()
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion?(.success(data))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
    }
}