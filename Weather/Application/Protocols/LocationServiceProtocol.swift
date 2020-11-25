//
//  LocationServiceMock.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 25.11.20.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    var didUpdateLocationStatus: ((LocationService.LocationState) -> Void)? { get set }
    var userLocation: CLLocation? { get }
    func start()
}
