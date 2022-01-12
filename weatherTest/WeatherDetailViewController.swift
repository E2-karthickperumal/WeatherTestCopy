//
//  WeatherDetail.swift
//  weatherTest
//
//  Created by E2info on 28/12/21.
//

import UIKit
class WeatherDetailViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    // Mark - Outlets
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var detailWeatherIcon: UIImageView!
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
    
        dismiss(animated: true, completion: nil)
    }
    
  // Mark - DataSource

    var detailList:list? = nil
    var city:city? = nil
    var list = [String]()
    var displayFunction = WeatherDetailsDisplayFunction()
    var dayLabelText = ""
    
    @IBOutlet weak var detailedTable: UITableView!

    override func viewDidLoad() {
        updateList()
        updateView()
        detailedTable.delegate = self
        detailedTable.dataSource = self
        detailedTable.reloadData()
        
    }

// Mark - DetailView List Updation
    func updateList(){
        var dummy = "Temperature         | \(displayFunction.getForCelsius(tempCelsius: (detailList?.main.temp)!)) / \(displayFunction.getForFahrenheit(tempFahrenheit: (detailList?.main.temp)!))"
        list.append(dummy)
        dummy = "Temperature Max | \(displayFunction.getForCelsius(tempCelsius: Double((detailList?.main.temp_max)!))) / \(displayFunction.getForFahrenheit(tempFahrenheit: Double((detailList?.main.temp_max)!)))"
        list.append(dummy)
        dummy = "Temperature Min  | \(displayFunction.getForCelsius(tempCelsius: Double((detailList?.main.temp_min)!))) / \(displayFunction.getForFahrenheit(tempFahrenheit: Double((detailList?.main.temp_min)!)))"
        list.append(dummy)
        dummy = "Humidity                | \((detailList?.main.humidity)!)"
        list.append(dummy)
        dummy = "Status                    | \((detailList?.weather[0].main)!)"
        list.append(dummy)
        dummy = "\((city?.sunrise)!)"
        dummy = "SunRise                 | \(displayFunction.getForRiseTime(Date(timeIntervalSince1970: Double(dummy)!)))"
        list.append(dummy)
        dummy = "\((city?.sunset)!)"
        dummy = "SunSet                  | \(displayFunction.getForRiseTime(Date(timeIntervalSince1970: Double(dummy)!)))"
        list.append(dummy)
        dayLabelText = "\(displayFunction.getDayForDate(Date(timeIntervalSince1970: Double(detailList!.dt)))) | \(displayFunction.getForTime(detailList!.dt_txt))"
        
    }
    
    // Mark - DetailView Display
    
    func updateView(){

        dayLabel.text = dayLabelText
        weatherIcon.image = UIImage(systemName: "\(displayFunction.weatherIconDisplay(id: detailList!.weather[0].id))")
    }
}

// Mark - TableView SetUp

extension WeatherDetailViewController{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"WeatherTableViewCell2", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
}
