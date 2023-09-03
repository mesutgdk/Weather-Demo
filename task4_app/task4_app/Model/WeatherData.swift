//
//  WeatherData.swift
//  task4_app
//
//  Created by Mesut Gedik on 3.09.2023.
//

import Foundation

struct WeatherData: Codable {
    let name : String
    let main : Main
    let weather : [Weather]
    
    
}
struct Main: Codable {
    let temp : Double
    let tempMin : Double
    let tempMax : Double
    
    enum CodingKeys: String, CodingKey{
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
struct Weather: Codable {
    let description: String
    let id: Int
}
