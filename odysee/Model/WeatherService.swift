//
//  WeatherService.swift
//  odysee
//
//  Created by chaleroux on 11/10/2021.
//

import Foundation

class WeatherService {
    
    private static let weatherURL = URL(string: "https://openweathermap.org/data/2.5")!
    //private static let imageURL = URL(string: "https://openweathermap.org/img/wn/\(icon).png")!
    
    
    let apiKey = APIKey.weatherAPI
    
    static func getWeather() {
        
        let request = getWeatherRequest()
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let responseJSON = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                }
            }
        }
        task.resume()
  }
    
    private static func getWeatherRequest() -> URLRequest {
        var request = URLRequest(url: weatherURL)
        request.httpMethod = "POST"
        let body = "q=paris&lang=fr&units=metric"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
    
}

