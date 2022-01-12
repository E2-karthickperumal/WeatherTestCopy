//
//  ViewController.swift
//  weatherTest
//
//  Created by E2info on 24/12/21.
//

import UIKit

class ViewController: UIViewController, WeatherManagerDelegate{
    
    // Mark - Outlets
    
    @IBOutlet weak var temperatureDisplay: UILabel!
    
    @IBOutlet weak var weatherTable: UITableView!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayDisplay: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var segmentClick: UISegmentedControl!
    
    @IBOutlet  var timeAndPlace: UIStackView!
    
    @IBOutlet  var segmentAndTable: UIStackView!
    
    // Mark - DataSource

    var dailyData = [list]()
    var city:city? = nil
    var weatherManager = WeatherManager()
    var displayFunction = WeatherDetailsDisplayFunction()
    var indexList:Int = 0
    var dailyEachData = [Int:[list]]()
    var dayDisplayText = " "
    var temperatureDisplayText = " "
    var weatherIconImage = UIImage(systemName: "clouds")
    
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    
    private func animate(){
        UIView.animate(withDuration: 1,animations: {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
            self.imageView.alpha = 0
        })
    }
    
    // Mark - View Initialiazation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeAndPlace.isHidden = true
        self.segmentAndTable.isHidden = true
        view.addSubview(imageView)
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
        
        weatherTable.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        weatherManager.delegate = self
        weatherTable.delegate = self
        weatherTable.dataSource = self
        weatherManager.fetchData()
        segmentClick.addTarget(self, action: #selector(segmentSelectorClick(_:)), for: .valueChanged)
        
    }
    
    // Mark - SegmentController Title & Function
    
    @objc func segmentSelectorClick(_ sender: UISegmentedControl) {
        
        dailyData.removeAll()
        indexList = sender.selectedSegmentIndex
        display(displayIndex: indexList)
        sender.setTitle(displayFunction.getDayForSegment(Date(timeIntervalSince1970: Double(dailyEachData[2]![0].dt))),forSegmentAt: 2)
        sender.setTitle(displayFunction.getDayForSegment(Date(timeIntervalSince1970: Double(dailyEachData[3]![0].dt))),forSegmentAt: 3)
        sender.setTitle(displayFunction.getDayForSegment(Date(timeIntervalSince1970: Double(dailyEachData[4]![0].dt))),forSegmentAt: 4)
        weatherTable.reloadData()
        
    }
    
    // Mark - Parsed Data into List
    
    func didUpdateWeather(weather:WeatherData){
         let dailyUpdate = weather.list
         city = weather.city
        fiveDays(fiveData: dailyUpdate)
       
    }
    
    // Mark - List Data Sorting
    
    func fiveDays(fiveData:[list]){
        var dataIndex = 0
        var indexCount = 0
        while(indexCount < fiveData.count){
            
            let begin = fiveData[indexCount].dt_txt
            let test = displayFunction.getDateForSort(begin)
            var start = indexCount
            
            while(start < fiveData.count) {
                
                let fetch = fiveData[start].dt_txt
                let end = displayFunction.getDateForSort(fetch)
                if test == end {
                    
                    dailyData.append(fiveData[start])
                    start += 1
                    
                }else{
                    
                    break
                    
                }
            }
            
            dailyEachData.updateValue(dailyData, forKey: dataIndex)
            dataIndex += 1
            dailyData.removeAll()
            indexCount = start
            
        }
        self.display(displayIndex: 0)
        self.weatherDetails(indexValue: 0)
        
    }
    
    // Mark - Setting Up Data For TableView
    
    func display(displayIndex:Int){
        
        dailyData.append(contentsOf: dailyEachData[displayIndex]!)
    }
    
    // Mark - Data for Time & Place StackView
    
    func weatherDetails(indexValue:Int){
       DispatchQueue.main.asyncAfter(deadline: .now()+1.25) {
        
             let icon = self.dailyData[indexValue]
             self.weatherIconImage = UIImage(systemName: "\(self.displayFunction.weatherIconDisplay(id: icon.weather[0].id))")
             self.temperatureDisplayText = "\(self.displayFunction.getForCelsius(tempCelsius: icon.main.temp)) | \(self.displayFunction.getForTime(icon.dt_txt))"
             self.dayDisplayText = self.displayFunction.getDayForDate(Date(timeIntervalSince1970: Double(icon.dt)))
            self.weatherDetailDisplay()
            
       }

    }
    
    // Mark - Weather Details Display
    
    func weatherDetailDisplay(){
        self.timeAndPlace.isHidden = false
         self.segmentAndTable.isHidden = false
        self.segmentSelectorClick(self.segmentClick)
        self.weatherIcon.image = self.weatherIconImage
            self.temperatureDisplay.text = self.temperatureDisplayText
            self.dayDisplay.text = self.dayDisplayText
            self.weatherTable.reloadData()
        

    }
}

// Mark - TableView Setup

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:WeatherTableViewCell.identifier,for: indexPath) as! WeatherTableViewCell
        
        cell.configure(withDailyDataList: dailyData[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = (storyboard?.instantiateViewController(identifier: "WeatherDetailViewController"))! as WeatherDetailViewController
        guard let path = weatherTable.indexPathForSelectedRow else { return}
        let detailList = dailyData[path.row]
        destinationVC.detailList = detailList
        destinationVC.city = city
        present(destinationVC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
