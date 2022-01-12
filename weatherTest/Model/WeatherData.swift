//
//  WeatherData.swift
//  weatherTest
//
//  Created by E2info on 27/12/21.
//

import Foundation
struct WeatherData:Decodable {
   var list:[list]
    let city:city
    let cnt:Int
    
}

struct list:Decodable {
    let dt:Int
    let main:main
    var weather:[weather] 
    let dt_txt:String

}

struct main:Decodable {
    let temp:Double
    let temp_min:Float
    let temp_max:Float
    let humidity:Int
    let temp_kf:Float
}


struct weather:Decodable {
    let main:String
    let description:String
    let id:Int
}

struct city:Decodable {
    let sunrise:Int
    let sunset:Int
}
