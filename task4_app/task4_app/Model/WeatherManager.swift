//
//  WeatherManager.swift
//  task4_app
//
//  Created by Mesut Gedik on 3.09.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didFailWithError(error: Error)
}

enum NetworkError: Error {
    case invalidURL
    case dataParsingFailed
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey: String = "3624c94118857997b2e84b137581e05f"

    

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlString = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        print(urlString)
        performRequest(urlString: urlString, completion: completion)
    }
    
    private func performRequest(urlString: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
         guard let url = URL(string: urlString) else {
             completion(.failure(NetworkError.invalidURL))
             return
         }

         let session = URLSession(configuration: .default)
         let task = session.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 completion(.failure(error))
                 return
             }

             if let safeData = data, let weather = parseJSON(weatherData: safeData) {
                 completion(.success(weather))
             } else {
                 completion(.failure(NetworkError.dataParsingFailed))
             }
         }
         task.resume()
     }
    // parsing JSON
    
    
    private func parseJSON(weatherData: Data) -> WeatherModel? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather.first?.id ?? 0
            let temp = decodedData.main.temp
            let tempMin = decodedData.main.tempMin
            let tempMax = decodedData.main.tempMax
            let name = decodedData.name

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, minTemp: tempMin, maxtemp: tempMax)
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

