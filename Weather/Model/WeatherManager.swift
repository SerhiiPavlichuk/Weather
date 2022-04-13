//
//  WeatherManager.swift
//  Weather
//
//  Created by admin on 13.04.2022.
//

import Foundation

struct WeatherManager {

    let apiKey:String
    let weatherUrl: String
    
    init() {
        self.apiKey = (Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String)!
        self.weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric"
    }
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        print(urlString)
    }
}
