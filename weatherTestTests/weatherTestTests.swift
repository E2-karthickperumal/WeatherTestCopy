//
//  weatherTestTests.swift
//  weatherTestTests
//
//  Created by e2info  on 07/01/22.
//

import XCTest

@testable import weatherTest

class weatherTestTests: XCTestCase {
    
    var viewController:ViewController!
    var detailViewController:WeatherDetailViewController!
    
    // Mark - ViewController Loaded
    
    func testVCLoaded(){
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        viewController = storyBoard.instantiateViewController(identifier: "ViewController")
        
        
        viewController.loadViewIfNeeded()
        XCTAssertTrue(viewController.segmentAndTable.isHidden)
        XCTAssertTrue(viewController.timeAndPlace.isHidden)
        viewController.weatherManager.fetchData()

        XCTAssertNotNil(viewController.weatherTable)
        XCTAssertNotNil(viewController.weatherIcon)
        XCTAssertNotNil(viewController.temperatureDisplay)
        XCTAssertNotNil(viewController.placeLabel)
        
    }

    // Mark - ParseJson Valid Data
    
    func testParseJson(){
        

        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        viewController = storyBoard.instantiateViewController(identifier: "ViewController")
        viewController.loadViewIfNeeded()
        XCTAssertTrue(viewController.segmentAndTable.isHidden)
        XCTAssertTrue(viewController.timeAndPlace.isHidden)
        viewController.weatherManager.fetchData()

        let parseData = "{\"cod\":\"200\",\"message\":0,\"cnt\":40,\"list\":[{\"dt\":1641546000,\"main\":{\"temp\":301.34,\"feels_like\":304.48,\"temp_min\":299.97,\"temp_max\":301.34,\"pressure\":1017,\"sea_level\":1017,\"grnd_level\":1011,\"humidity\":72,\"temp_kf\":1.37},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":69},\"wind\":{\"speed\":5.28,\"deg\":60,\"gust\":4.51},\"visibility\":10000,\"pop\":0.02,\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2022-01-07 09:00:00\"}],\"city\":{\"id\":1264527,\"name\":\"Chennai\",\"coord\":{\"lat\":13.0878,\"lon\":80.2785},\"country\":\"IN\",\"population\":4328063,\"timezone\":19800,\"sunrise\":1641517385,\"sunset\":1641558390}}".data(using: String.Encoding.utf8)
        let updateData = viewController.weatherManager.parseJSON(weatherData: parseData!)
        
        viewController.didUpdateWeather(weather: updateData!)
        
        
        XCTAssertEqual(Double(301.34),self.viewController.dailyData[0].main.temp)
        XCTAssertNotNil(self.viewController.temperatureDisplayText)
        XCTAssertNotNil(self.viewController.dayDisplayText)
    }
    
    // Mark - ParseJson Invalid Data
    
    func testParseNonJson(){
        let sut = ViewController()
        
        let data = "Test ERROR....".data(using: String.Encoding.utf8)
        
        guard sut.weatherManager.parseJSON(weatherData: data!) != nil else {
            XCTFail("Couln't parse the data")
            return
        }
        
    }
    
    // Mark - WeatherDetailViewController Loaded
    
    func testDetailViewDisplay(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        viewController = storyBoard.instantiateViewController(identifier: "ViewController")
        let parseData = "{\"cod\":\"200\",\"message\":0,\"cnt\":40,\"list\":[{\"dt\":1641546000,\"main\":{\"temp\":301.34,\"feels_like\":304.48,\"temp_min\":299.97,\"temp_max\":301.34,\"pressure\":1017,\"sea_level\":1017,\"grnd_level\":1011,\"humidity\":72,\"temp_kf\":1.37},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04d\"}],\"clouds\":{\"all\":69},\"wind\":{\"speed\":5.28,\"deg\":60,\"gust\":4.51},\"visibility\":10000,\"pop\":0.02,\"sys\":{\"pod\":\"d\"},\"dt_txt\":\"2022-01-07 09:00:00\"}],\"city\":{\"id\":1264527,\"name\":\"Chennai\",\"coord\":{\"lat\":13.0878,\"lon\":80.2785},\"country\":\"IN\",\"population\":4328063,\"timezone\":19800,\"sunrise\":1641517385,\"sunset\":1641558390}}".data(using: String.Encoding.utf8)
        let updateData = viewController.weatherManager.parseJSON(weatherData: parseData!)
        viewController.didUpdateWeather(weather: updateData!)
        
        
        detailViewController = storyBoard.instantiateViewController(identifier: "WeatherDetailViewController")
        detailViewController.detailList = viewController.dailyData[0]
        detailViewController.city = viewController.city
        detailViewController.updateList()
       
        XCTAssertNotNil(detailViewController.list.count)
        XCTAssertNotNil(detailViewController.dayLabelText)
    }
    
}
