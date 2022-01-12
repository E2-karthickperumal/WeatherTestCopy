//
//  WeatherTableViewCell.swift
//  weatherTest
//
//  Created by E2info on 24/12/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib()->UINib{
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    var displayFunction = WeatherDetailsDisplayFunction()
    
    func configure(withDailyDataList:list){

        self.mainLabel.text = "\(withDailyDataList.weather[0].main)"
        self.tempLabel.text = "\( displayFunction.getForCelsius(tempCelsius: withDailyDataList.main.temp)) | \(displayFunction.getForFahrenheit(tempFahrenheit: withDailyDataList.main.temp))"
        self.dayLabel.text = displayFunction.getForTime(withDailyDataList.dt_txt)
        
    }
}
