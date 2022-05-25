//
//  WeatherViewController.swift
//  Weather
//
//  Created by admin on 11.04.2022.
//

import UIKit
import CoreLocation
import SnapKit

class WeatherViewController: UIViewController {

    //MARK: - Property

    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()

    private lazy var background: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "background")
        background.contentMode = .scaleAspectFill
        return background
    }()

    private lazy var locationButton: UIButton = {
        let locationButton = UIButton()
        let image = UIImage(systemName: "location.circle.fill") as UIImage?
        locationButton.setBackgroundImage(image, for: .normal)
        locationButton.tintColor = UIColor(red: 27/255, green: 67/255, blue: 72/255, alpha: 1)
        locationButton.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return locationButton
    }()

    private lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        let image = UIImage(systemName: "magnifyingglass")
        searchButton.setBackgroundImage(image, for: .normal)
        searchButton.tintColor = locationButton.tintColor
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return searchButton
    }()

    private lazy var conditionImageView: UIImageView = {
        let conditionImageView = UIImageView()
        conditionImageView.contentMode = .scaleAspectFill
        conditionImageView.clipsToBounds = true
        conditionImageView.tintColor = locationButton.tintColor
        return conditionImageView
    }()

    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.font = .systemFont(ofSize: 80, weight: .black)
        return temperatureLabel
    }()

    private lazy var temperatureSign: UILabel = {
        let temperatureSign = UILabel()
        temperatureSign.text = "°C"
        temperatureSign.font = .systemFont(ofSize: 80, weight: .black)
        return temperatureSign
    }()

    private lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = .systemBackground
        searchTextField.font = .systemFont(ofSize: 30, weight: .regular)
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .right
        searchTextField.autocapitalizationType = .words
        return searchTextField
    }()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = .systemFont(ofSize: 30, weight: .regular)
        return cityLabel
    }()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    //MARK: - Button Methods

    @objc func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    @objc func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - TextField Delegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type someting"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - Weather Manager Delegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Location Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
