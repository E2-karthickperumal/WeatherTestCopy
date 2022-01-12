//
//  WeatherManager.swift
//  weatherTest
//
//  Created by E2info on 27/12/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:WeatherData)
}
struct WeatherManager {
    
    

    var delegate:WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=CHENNAI&appid=c5c630a04ee4f1aae71728d960e807c3&units=metric"
    
   func fetchData(){
        guard let url = URL(string: weatherURL) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url,completionHandler: { data, response, error in
            if error != nil{
                print(error!)
                return
            }
            if let safeData = data{
                if let weather = parseJSON(weatherData: safeData){
                    self.delegate?.didUpdateWeather(weather:weather )
                }
            }
        })
        
        task.resume()
    
    }
    func parseJSON(weatherData:Data)->WeatherData?{
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           
            return decodedData
        }catch{
            print(error)
            return nil
        }
    }
    
    
}
