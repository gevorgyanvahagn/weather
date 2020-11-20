//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var weatherImageView: UIImageView!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
