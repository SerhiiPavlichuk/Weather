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
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let saveData = data {
                    parseJSON(weatherData: saveData)
                }
            }
            task.resume()
        }
    }

    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.main.temp)
        } catch {
            print(error)
        }
    }
}
