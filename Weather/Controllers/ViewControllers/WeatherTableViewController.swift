//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import UIKit

final class WeatherTableViewController: UIViewController {
    
    @IBOutlet private weak var headerView: WeatherHeaderView!
    @IBOutlet private weak var tableView: UITableView!
    
    public var userSettings: UserSettings!
    private var dataSource: [Dictionary<Date, [Forecast]>.Element] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func updateDatasource(_ dataSource: [Forecast]) {
        organizeDataSource(dataSource)
        tableView.reloadData()
    }
    
    public func updateHeaderView(_ forecast: Forecast) {
        configureHeaderView(with: forecast)
    }
    
    private func organizeDataSource(_ dataSource: [Forecast]) {
        self.dataSource = Dictionary(grouping: dataSource) { (forecast) -> Date in
            let date = Calendar.current.startOfDay(for: forecast.date)
            return date
        }.sorted(by: { $0.key < $1.key})
    }
    
    private func configureHeaderView(with forecast: Forecast) {
        if let sunrise = forecast.system.sunrise {
            // TODO: - Add localization
            headerView.sunriseLabel.text = "Sunrise: \(DateFormatter.globalHourFormatter.string(from: sunrise))"
        }
        
        if let sunset = forecast.system.sunset {
            // TODO: - Add localization
            headerView.sunsetLabel.text = "Sunset \(DateFormatter.globalHourFormatter.string(from: sunset))"
        }
        
            let temperatureText = MeasurementFormatter.temperatureFormatter(forecast.main.temperature, with: userSettings.unit.unitTemperature).replacingOccurrences(of: "°", with: " °")
            headerView.temperatureLabel.text = temperatureText
        
        if let description = forecast.weather.first?.weatherDescription {
            headerView.weatherDescriptionLabel.text = description.capitalized
        }
            // TODO: - Add localization
            headerView.visibilityLabel.text = "Visibility: \(forecast.visibility) m"
        // TODO: - Add localization
        headerView.windSpeedLabel.text = "Wind: \(forecast.wind.speed) m/s"
        if let iconName = forecast.weather.first?.icon {
            let url = Constants.Links.iconsEndpoint.appendingPathComponent("\(iconName).png")
            headerView.weatherImageView.setImage(with: url)
        }
    }
    
    private func configure(_ cell: inout WeatherTableViewCell, with forecast: Forecast) {
        
            cell.timeLabel.text = DateFormatter.globalHourFormatter.string(from: forecast.date)

        
        if let description = forecast.weather.first?.weatherDescription {
            let temperatureText = MeasurementFormatter.temperatureFormatter(forecast.main.temperature, with: userSettings.unit.unitTemperature).replacingOccurrences(of: "°", with: " °")
            cell.temperatureLabel.text = "\(description.capitalized), \(temperatureText)"
        } else {
            cell.temperatureLabel.text = ""
        }
        
        if let iconName = forecast.weather.first?.icon {
            let url = Constants.Links.iconsEndpoint.appendingPathComponent("\(iconName).png")
            cell.weatherImageView.setImage(with: url)
        } else {
            cell.weatherImageView.image = nil
        }
    }
}

// MARK: - Table view data source
extension WeatherTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        DateFormatter.globalWeekdayFormatter.string(from: dataSource[section].key)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.className, for: indexPath) as? WeatherTableViewCell else {
            fatalError()
        }
        let forecast = dataSource[indexPath.section].value[indexPath.row]
        configure(&cell, with: forecast)
        return cell
    }
}
