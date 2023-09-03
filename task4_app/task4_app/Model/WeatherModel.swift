//
//  WeatherModel.swift
//  task4_app
//
//  Created by Mesut Gedik on 3.09.2023.
//

import Foundation

struct WeatherModel {
    let conditionId : Int
    let cityName : String
    let temperature : Double
    let minTemp : Double
    let maxtemp : Double
    
    var conditionName : String{
        switch conditionId {
        case 200 ... 299:
            return "cloud.bolt"
        case 300 ... 399:
            return "cloud.drizzle"
        case 500 ... 599:
            return "cloud.rain"
        case 600 ... 699:
            return "cloud.snow"
        case 700 ... 799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801 ... 899:
            return "cloud"
            
        default:
            return "cloud.sun"
        }
    }
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    var tempMinString : String {
        return "Min: " + String(format: "%.1f", minTemp) + " °C"
    }
    var tempMaxString : String {
        return "Max: " + String(format: "%.1f", maxtemp) + " °C"
    }
}
