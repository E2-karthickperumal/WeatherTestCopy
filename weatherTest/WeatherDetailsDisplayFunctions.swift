//
//  WeatherModel.swift
//  weatherTest
//
//  Created by E2info on 28/12/21.
//

import Foundation
struct WeatherDetailsDisplayFunction {
    
    // Mark - Weather Icon Display
    
    func weatherIconDisplay(id:Int)->String{
        
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
        
    }

    // Mark - Temperature Celsius Conversion
    
    func getForCelsius(tempCelsius:Double) -> String {
        let temperatureCelsius = Measurement(value: tempCelsius, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: temperatureCelsius)
    }


    // Mark - Temperature Fahrenheit Conversion
    
    func getForFahrenheit(tempFahrenheit:Double) -> String {
        let temperatureCelsius = Measurement(value: tempFahrenheit, unit: UnitTemperature.celsius)
        let temperatureFahrenheit = temperatureCelsius.converted(to: .fahrenheit)
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        return formatter.string(from: temperatureFahrenheit)
    }

    // Mark - Date Function
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: inputDate)
    }

    // Mark - Date for SegmentControl Index
    
    func getDayForSegment(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        return formatter.string(from: inputDate)
    }

    // Mark - Time Function
    
    func getForTime(_ date: String) -> String {
        let check = date

        let informatter = DateFormatter()
        informatter.locale = Locale(identifier: "en_US_POSIX")
        informatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let outformatter = DateFormatter()
        outformatter.locale = Locale(identifier: "en_US_POSIX")
        outformatter.dateStyle = .medium
        outformatter.dateFormat = "h:mm a"
        let check3 = informatter.date(from: check)

        return outformatter.string(from: check3!)

    }

    // Mark - Date for List Sorting
    
    func getDateForSort(_ date: String) -> String {
        let check = date

        let informatter = DateFormatter()
        informatter.locale = Locale(identifier: "en_US_POSIX")
        informatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let outformatter = DateFormatter()
        outformatter.locale = Locale(identifier: "en_US_POSIX")
        outformatter.dateStyle = .medium
        outformatter.dateFormat = "yyyy-MM-dd"
        let check3 = informatter.date(from: check)

        return outformatter.string(from: check3!)
    }

    // Mark - SunRise & SunSet Function
    
    func getForRiseTime(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
       formatter.dateFormat = "h:mm a"
        return formatter.string(from: inputDate)
    }
}
