//
//  WeatherViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private var locationService = LocationService()
    private var weatherTableViewController: WeatherTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationService()
        addUserSettingsObserver()
    }
    
    private func configureLocationService() {
        locationService.start()
        locationService.didUpdateLocationStatus = { [weak self] status in
            switch status {
            case .didUpdateLocation(let location):
                self?.loadForecastData()
            case .denied:
                // TODO: - Handle this case
                print("Denided")
            }
        }
    }
    
    private func addUserSettingsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(userSettingsChanged), name: NSNotification.Name.userSettingsUnitChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userSettingsChanged), name: NSNotification.Name.userSettingsLanguageChanged, object: nil)
    }
    
    @objc private func userSettingsChanged() {
        loadForecastData()
    }
    
    @IBSegueAction private func showWeatherTableViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?)
        -> WeatherTableViewController? {
        weatherTableViewController = WeatherTableViewController(coder: coder, dataSource: [])
        return weatherTableViewController
    }
    
    private func loadForecastData() {
        Router.fiveDayWeatherForecast(countryCode: "Yerevan", language: UserSettings.language, unit: UserSettings.unit).request { (result: Result<GenericContainer<Forecast>, Error>) in
            switch result {
            case .success(let container):
                self.weatherTableViewController?.updateDatasource(container.list ?? [])
                self.title = container.city?.name
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        Router.currentWeatherForecast(countryCode: "Yerevan", language: UserSettings.language, unit: UserSettings.unit).request { (result: Result<Forecast, Error>) in
            switch result {
            case .success(let forecast):
                self.weatherTableViewController?.updateHeaderView(forecast)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

