//
//  ViewController.swift
//  task4_app
//
//  Created by Mesut Gedik on 3.09.2023.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController{
    
    private let locantionManager = CLLocationManager ()
        
    private var weatherManager = WeatherManager()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cloud.sun")
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "33 °C"
        return label
    }()
    
    private let maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22,weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Max: 40 °C"
        return label
    }()
    
    private let minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Min: 28 °C"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 33)
        label.textAlignment = .center
        label.text = "Istanbul"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()

    }
    //Setup
    private func setup(){
        view.backgroundColor = .systemBackground
        
        view.addSubviews(
            locationLabel,
            weatherImageView,
            temperatureLabel,
            minLabel,
            maxLabel
        )
        
        locantionManager.delegate = self
        locantionManager.requestWhenInUseAuthorization()
        locantionManager.requestLocation()
        
        weatherManager.delegate = self
        
        findWhereIsHere()

    }
    
    private func layout (){
        //LocationLabel
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 8),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        //weatherImageView
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalToSystemSpacingBelow: locationLabel.bottomAnchor, multiplier: 2),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor)
        ])
        //temperatureLabel
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalToSystemSpacingBelow: weatherImageView.bottomAnchor, multiplier: 2),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        //minTempLabel
        NSLayoutConstraint.activate([
            minLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 2),
            minLabel.rightAnchor.constraint(equalTo: view.centerXAnchor),
            minLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        //maxTempLabel
        NSLayoutConstraint.activate([
            maxLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 2),
            maxLabel.leftAnchor.constraint(equalTo: view.centerXAnchor),
            maxLabel.widthAnchor.constraint(equalTo: minLabel.widthAnchor)
        ])
        
    }
   
}
// MARK: - CLLocationManagerDelegate
extension ViewController:  CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locantionManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon) { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        
                        self.minLabel.text = weather.tempMinString
                        self.temperatureLabel.text = weather.temperatureString
                        self.maxLabel.text = weather.tempMaxString
                        self.weatherImageView.image = UIImage(systemName: weather.conditionName)
                        self.locationLabel.text = weather.cityName
                        
                        print("Weather: \(weather)")
                    }
                case .failure(let error):
                    
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func findWhereIsHere(){
        locantionManager.requestLocation()
    }
}
// MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {

    func didFailWithError(error: Error) {

        print(error.localizedDescription)
    }
}

