//
//  ViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    private var locationService = LocationService()
    private var weatherTableViewController: WeatherTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationService.start()
        locationService.didUpdateLocationStatus = { [weak self] status in
            switch status {
            case .didUpdateLocation(let location):
                print("longitude: ", location.coordinate.longitude)
                print("latitude: ", location.coordinate.latitude)
                self?.label.text = nil
            case .denied:
                self?.label.text = "Please, go to settings and enable location services to continue using the app"
            }
        }
    }
    
    @IBSegueAction
    private func showWeatherTableViewController(coder: NSCoder, sender: Any?, segueIdentifier: String?)
        -> WeatherTableViewController? {
        weatherTableViewController = WeatherTableViewController(coder: coder, dataSource: [])
        return weatherTableViewController
    }
    
    @IBAction private func buttonTapped() {
        print("Button tapped")
        
        Router.fiveDayWeatherForecast(countryCode: "arm").request { (result: Result<GenericContainer<Forecast>, Error>) in
            switch result {
            case .success(let container):
                print(container.list)
                self.weatherTableViewController?.updateDatasource(container.list ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

