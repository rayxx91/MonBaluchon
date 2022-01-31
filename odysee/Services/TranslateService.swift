//
//  TranslateService.swift
//  odysee
//
//  Created by chaleroux on 07/12/2021.
//

import Foundation

class Translate {
    
    // MARK: - Properties
    
    let apiKey = APIKey.translateAPI
    let urlTranslate = URL(string: "https://translation.googleapis.com/language/translate/v2?")!
    var session = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    
    // MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    
    //MARK: - Body
    
    func getTraduction(text: String, callback: @escaping (Translation?, ErrorCases?) -> Void) {
        let request = createTranslateRequest(text: text)
        task = session.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    callback(nil, ErrorCases.failure)
                    return
                }
                
                guard let unwrappedData = data else {
                    callback(nil, ErrorCases.noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print(self.urlTranslate)
                    print(request)
                    callback(nil, ErrorCases.wrongResponse(error))
                    return
                }
                
                do {
                    let responseJSON = try JSONDecoder().decode(Translation.self, from: unwrappedData)
                    callback(responseJSON, nil)
                    print("This is the result of the translation:", responseJSON)
                } catch {
                    callback(nil, ErrorCases.errorDecode(error))
                }
            }
        }
        task?.resume()
    }
    
    func createTranslateRequest(text: String) -> URLRequest {
        var request = URLRequest(url: urlTranslate)
        request.httpMethod = "POST"
        let q = text
        
        let body = "q=\(q)" + "&source=fr" + "&target=en" + "&format=text" + "&key=\(apiKey)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}


