//
//  AppDelegate.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = self.window?.rootViewController as? UINavigationController
        let controller = navigationController?.topViewController as? WeatherViewController
        let locationService = LocationService()
        controller?.locationService = locationService
        
        return true
    }
}

