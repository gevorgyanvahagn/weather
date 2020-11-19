//
//  ViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 19.11.20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func buttonTapped() {
        print("Button tapped")
        
        Router.fiveDayWeatherForecast(countryCode: "arm").request { (result: Result<GenericContainer<Forecast>, Error>) in
            switch result {
            case .success(let container):
                print(container.list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

