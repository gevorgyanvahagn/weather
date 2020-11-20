//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import UIKit

final class WeatherTableViewController: UIViewController {
    
    @IBOutlet private weak var headerView: WeatherHeaderView?
    @IBOutlet private weak var tableView: UITableView?
    private var dataSource: [Dictionary<Date, [Forecast]>.Element] = []
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init?(coder: NSCoder, dataSource: [Forecast]) {
        super.init(coder: coder)
        updateDatasource(dataSource)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func updateDatasource(_ dataSource: [Forecast]) {
        organizeDataSource(dataSource)
        tableView?.reloadData()
    }
    
    public func updateHeaderView(_ forecast: Forecast) {
        configureHeaderView(with: forecast)
    }
    
    private func organizeDataSource(_ forecast: [Forecast]) {
        // TODO: - Handle force unwrap case
        dataSource = Dictionary(grouping: forecast) { (forecast) -> Date in
            let date = Calendar.current.startOfDay(for: forecast.date!)
            return date
        }.sorted(by: { $0.key < $1.key})
    }
    
    private func configureHeaderView(with forecast: Forecast) {
        if let sunrise = forecast.system?.sunrise {
            // TODO: - Add localization
            headerView?.sunriseLabel.text = "Sunrise: \(DateFormatter.globalHourFormatter.string(from: sunrise))"
        } else {
            headerView?.sunriseLabel.text = ""
        }
        
        if let sunset = forecast.system?.sunset {
            // TODO: - Add localization
            headerView?.sunsetLabel.text = "Sunset \(DateFormatter.globalHourFormatter.string(from: sunset))"
        } else {
            headerView?.sunsetLabel.text = ""
        }
        
        if let temperature = forecast.main?.temperature {
            let celsius = MeasurementFormatter.temperatureConverter(temperature, from: .kelvin, to: .celsius)
            let temperatureText = celsius.replacingOccurrences(of: "°C", with: " °C")
            headerView?.temperatureLabel.text = temperatureText
        } else {
            headerView?.temperatureLabel.text = ""
        }
        
        if let description = forecast.weather?.first?.main {
            headerView?.weatherDescriptionLabel.text = description
        } else {
            headerView?.weatherDescriptionLabel.text = ""
        }
        
        if let visibility = forecast.visibility {
            // TODO: - Add localization
            headerView?.visibilityLabel.text = "Visibility: \(visibility) m"
        } else {
            headerView?.visibilityLabel.text = ""
        }
        
        if let wind = forecast.wind?.speed {
            // TODO: - Add localization
            headerView?.windSpeedLabel.text = "Wind: \(wind) m/s"
        } else {
            headerView?.windSpeedLabel.text = ""
        }
        
        if let iconName = forecast.weather?.first?.icon {
            let url = Constants.Links.iconsEndpoint.appendingPathComponent("\(iconName).png")
            headerView?.weatherImageView.setImage(with: url)
        } else {
            headerView?.weatherImageView?.image = nil
        }
    }
    
    private func configure(_ cell: inout WeatherTableViewCell, with forecast: Forecast) {
        if let date = forecast.date {
            cell.timeLabel.text = DateFormatter.globalHourFormatter.string(from: date)
        } else {
            cell.timeLabel.text = ""
        }
        
        if let temperature = forecast.main?.temperature, let description = forecast.weather?.first?.main {
            let celsius = MeasurementFormatter.temperatureConverter(temperature, from: .kelvin, to: .celsius)
            let temperatureText = celsius.replacingOccurrences(of: "°C", with: " °C")
            cell.temperatureLabel.text = "\(description), \(temperatureText)"
        } else {
            cell.temperatureLabel.text = ""
        }
        
        if let iconName = forecast.weather?.first?.icon {
            let url = Constants.Links.iconsEndpoint.appendingPathComponent("\(iconName).png")
            cell.weatherImageView.setImage(with: url)
        } else {
            cell.imageView?.image = nil
        }
    }
}

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
