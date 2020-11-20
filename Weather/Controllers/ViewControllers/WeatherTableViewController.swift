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
}

extension WeatherTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.className, for: indexPath)
        return cell
    }
}
