//
//  ViewController.swift
//  task4_app
//
//  Created by Mesut Gedik on 3.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
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
        label.font = UIFont.systemFont(ofSize: 33, weight: .medium)
        label.textAlignment = .center
        label.text = "33 °C"
        return label
    }()
    
    private let maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22,weight: .light)
        label.textAlignment = .center
        label.text = "Max: 40 °C"
        return label
    }()
    
    private let minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.textAlignment = .center
        label.text = "Min: 28 °C"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Light", size: 33)
        label.textAlignment = .center
        label.text = "ADANA"
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
    }
    
    private func layout (){
        //LocationLabel
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 8),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.widthAnchor.constraint(equalToConstant: 150)
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
            minLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
        //maxTempLabel
        NSLayoutConstraint.activate([
            maxLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 2),
            maxLabel.leftAnchor.constraint(equalTo: view.centerXAnchor),
            maxLabel.widthAnchor.constraint(equalTo: minLabel.widthAnchor)
        ])
        
    }

}

