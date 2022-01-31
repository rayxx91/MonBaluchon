//
//  WeatherViewController.swift
//  odysee
//
//  Created by chaleroux on 13/01/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var myTownLabel: UILabel!
    @IBOutlet weak var firstDescriptionLabel: UILabel!
    @IBOutlet weak var firstTempLabel: UILabel!
    @IBOutlet weak var firstIconImage: UIImageView!
    
    @IBOutlet weak var secondTownLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var secondTempLabel: UILabel!
    @IBOutlet weak var secondIconImage: UIImageView!
    
    // MARK: Proprieties
    
    let mpl: Int = 2991118
    let ny: Int = 5128581
    
    
    // MARK: Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    // MARK: Methods
    private func getData() {
        let api = WeatherService(session: URLSession(configuration: .default))
        
        api.getWeather(id: mpl) { (weather, image, error) in
            if let error = error {
                self.alert(title: "ERROR", message: error.localizedDescription)
            } else if let weather = weather, let image = image {
                DispatchQueue.main.async {
                    self.firstTempLabel.text = "\(weather.main.temp)ºC"
                    self.firstDescriptionLabel.text = weather.weather[0].description
                    self.firstIconImage.image = image
                }
            } else {
                print("There is a problem, getData.mtp is wrong")
            }
        }
        
        api.getWeather(id: ny) { (weather, image, error) in
            if let error = error {
                print("There was an error in getWeather: \(error.localizedDescription)")
            } else if let weather = weather, let image = image {
                DispatchQueue.main.async {
                    self.secondTempLabel.text = "\(weather.main.temp)ºC"
                    self.secondDescriptionLabel.text = weather.weather[0].description
                    self.secondIconImage.image = image
                }
            } else {
                print("There is a problem when I get data for ny")
            }
        }
        
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
