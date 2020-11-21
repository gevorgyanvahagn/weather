//
//  WeatherLoadingViewController.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 21.11.20.
//

import UIKit

class WeatherLoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var openSettingsView: UIView!
    
    public enum State {
        case loading
        case showOpenSettingsView
    }
    
    public func set(_ state: WeatherLoadingViewController.State) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            openSettingsView.isHidden = true
        case .showOpenSettingsView:
            activityIndicator.stopAnimating()
            openSettingsView.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func openSettingsButtonPressed(_ sender: UIButton) {
        print("asdasdasd")
    }
    
}
