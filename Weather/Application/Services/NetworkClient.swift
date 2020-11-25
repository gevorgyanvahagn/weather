//
//  NetworkClient.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 26.11.20.
//

import Foundation
import Alamofire

class NetworkClient: NetworkClientProtocol {
    
    func request<T: Decodable>(_ builder: URLBuilder, completion: ((Result<T, Error>) -> Void)?) {
        
        guard let url = try? builder.asURL() else {
            assertionFailure()
            // TODO: - Add localisation to error message
            completion?(.failure(NetworkError.invalidRequest(reason: "Data missing")))
            return
        }
        
        AF.request(url, method: builder.method, parameters: builder.parameters, encoding: URLEncoding.default, headers: HTTPHeaders(builder.headers))
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
