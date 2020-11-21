//
//  WeatherViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet weak private var weatherTableViewContainer: UIView!
    @IBOutlet weak private var weatherLoadingViewContainer: UIView!
    
    private var weatherTableViewController: WeatherTableViewController?
    private var weatherLoadingViewController: WeatherLoadingViewController?
    
    private var locationService: LocationService?
    private var state: State?
    
    private enum State {
        case loading
        case locationAccessDenied
        case loaded
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationService()
        addUserSettingsObserver()
        set(.loading)
    }
    
    private func set(_ state: State) {
        switch state {
        case .loading:
            weatherTableViewContainer.isHidden = true
            weatherLoadingViewContainer.isHidden = false
            weatherLoadingViewController?.set(WeatherLoadingViewController.State.loading)
        case .loaded:
            weatherLoadingViewContainer.isHidden = true
            weatherTableViewContainer.isHidden = false
        case .locationAccessDenied:
            weatherTableViewContainer.isHidden = true
            weatherLoadingViewContainer.isHidden = false
            weatherLoadingViewController?.set(.showOpenSettingsView)
        }
        self.state = state
    }
    
    private func configureLocationService() {
        locationService = LocationService()
        locationService?.didUpdateLocationStatus = { [weak self] status in
            switch status {
            case .didUpdateLocation(let location):
                self?.loadForecastData(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
            case .denied:
                self?.set(.locationAccessDenied)
            }
        }
        locationService?.start()
    }
    
    private func addUserSettingsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(userSettingDidChange), name: NSNotification.Name.userSettingsUnitChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userSettingDidChange), name: NSNotification.Name.userSettingsLanguageChanged, object: nil)
    }
    
    @objc private func userSettingDidChange() {
        if let state = state, state == .locationAccessDenied {
            return
        }
        if let location = locationService?.userLocation {
            loadForecastData(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeatherTableViewController" {
            if let weatherTableViewController = segue.destination as? WeatherTableViewController {
                self.weatherTableViewController = weatherTableViewController
            }
        }
        
        if segue.identifier == "showWeatherLoadingController" {
            if let weatherLoadingViewController = segue.destination as? WeatherLoadingViewController {
                self.weatherLoadingViewController = weatherLoadingViewController
            }
        }
    }
    
    private func loadForecastData(longitude: Double, latitude: Double) {
        let group = DispatchGroup()
        
        group.enter()
        Router.fiveDayWeatherForecast(longitude: longitude, latitude: latitude, language: UserSettings.language, unit: UserSettings.unit).request { (result: Result<GenericContainer<Forecast>, Error>) in
            switch result {
            case .success(let container):
                self.weatherTableViewController?.updateDatasource(container.list ?? [])
                self.title = container.city?.name
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        Router.currentWeatherForecast(longitude: longitude, latitude: latitude, language: UserSettings.language, unit: UserSettings.unit).request { (result: Result<Forecast, Error>) in
            switch result {
            case .success(let forecast):
                self.weatherTableViewController?.updateHeaderView(forecast)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.set(.loaded)
        }
    }
    
}

