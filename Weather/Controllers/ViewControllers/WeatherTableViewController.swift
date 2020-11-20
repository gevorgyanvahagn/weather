//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import UIKit

final class WeatherTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    private(set) var dataSource: [Forecast] = []
    
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
        self.dataSource = dataSource
        tableView?.reloadData()
    }
    
    private func load(_ cell: inout WeatherTableViewCell, with forecast: Forecast) {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.className, for: indexPath) as? WeatherTableViewCell else {
            fatalError()
        }
        let forecast = dataSource[indexPath.row]
        load(&cell, with: forecast)
        return cell
    }
}
