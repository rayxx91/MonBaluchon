//
//  ExchangeService.swift
//  odysee
//
//  Created by chaleroux on 02/11/2021.
//

import Foundation
import UIKit

class ExchangeService {
    
    
    // MARK: - Properties
    
    let apiKey = APIKey.exchangeAPI
    var rates: Double?
    var session = URLSession(configuration: .default)
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    
    // MARK: - Body
    
    func getExchange(callback: @escaping (FixerResponse?, ErrorCases?) -> Void) {
        
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=EUR") else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    callback(nil, ErrorCases.failure)
                    return
                }
                
                guard let data = data else {
                    callback(nil, ErrorCases.noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    
                    callback(nil, ErrorCases.wrongResponse(error))
                    return
                }
                
                do {
                    let fixerResponse = try JSONDecoder().decode(FixerResponse.self, from: data)
                    callback(fixerResponse, nil)
                } catch {
                    callback(nil, ErrorCases.errorDecode(error))
                }
            }
        }
        task.resume()
        
    }
    
    // MARK: - Method
    
    func abreviateDeviseName(for devise: String) -> String? {
        
        let myResult: String
        
        switch devise {
        case "Australian Dollar": myResult = "AUD"
        case "Canadian Dollar": myResult = "CAD"
        case "Swiss Franc": myResult = "CHF"
        case "British Pound Sterling": myResult = "GBP"
        case "Mexicain Peso": myResult = "MXN"
        case "New Zealand Dollar": myResult = "NZD"
        case "United States Dollar": myResult = "USD"
        default:
            return ("break")
        }
        return myResult
    }
    
}

