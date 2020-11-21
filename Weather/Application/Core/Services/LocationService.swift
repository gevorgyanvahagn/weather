//
//  LocationService.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    public var didUpdateLocationStatus: ((LocationState) -> Void)?
    private var locationManager: CLLocationManager
    private(set) var userLocation: CLLocation?
    
    enum LocationState {
        case didUpdateLocation(CLLocation)
        case denied
    }
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }
    
    public func start() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        didUpdateLocationStatus?(.didUpdateLocation(location))
        userLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            didUpdateLocationStatus?(.denied)
        default:
            start()
        }
    }
}
