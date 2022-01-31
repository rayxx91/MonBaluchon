//
//  WeatherService.swift
//  odysee
//
//  Created by chaleroux on 11/10/2021.
//

import Foundation
import UIKit

class WeatherService {
    
    // MARK: - Properties
    
    let apiKey = APIKey.weatherAPI
    var session = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Body
    
    
    func getIcon(icon: String, callback: @escaping (UIImage?, Error?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let imgUrl = URL(string: "https://openweathermap.org/img/wn/\(icon).png")!
        
        task = session.dataTask(with: imgUrl) { (data, response, error) in
            guard error == nil else {
                callback(nil, ErrorCases.failure)
                return
            }
            
            guard let unwrappeData = data else {
                callback(nil, ErrorCases.noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(nil, ErrorCases.wrongResponse(error))
                return
            }
            let image = UIImage(data: unwrappeData)
            callback(image, nil)
        }
        task?.resume()
    }
    
    
    func getWeather(id: Int = 0, callback: @escaping (WeatherResponse?, UIImage?, ErrorCases?) -> Void) {
        
        guard let urlWeather = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(id)&appid=\(apiKey)&units=metric") else {
            return
        }
        
        let request = URLRequest(url: urlWeather)
        task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                callback(nil, nil, ErrorCases.failure)
                return
            }
            
            guard let data = data else {
                callback(nil, nil, ErrorCases.noData)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(urlWeather)
                callback(nil,nil,ErrorCases.wrongResponse(error))
                
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                if response.cod != 200 {
                    callback(nil, nil, .errorDecode(error!))
                } else {
                    let icon = response.weather.first(where: {$0.icon != ""})?.icon
                    if let icon = icon {
                        self.getIcon(icon: icon, callback: { (image, error) in
                            if let error = error {
                                callback(response, nil, error as? ErrorCases)
                            } else {
                                callback(response, image, nil)
                            }
                        })
                    }
                }
            } catch {
                callback(nil, nil, .errorDecode(error))
            }
        }
        task?.resume()
    }
}

