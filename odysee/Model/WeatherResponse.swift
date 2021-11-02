
struct Weather: Codable {
    let id: Int
    let weatherDescription: String
    let icon: String // main
    let main:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case main = "main"
        case weatherDescription = "description"
        case icon
    }
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Sys: Codable {
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String?
    let dt: Int
    let timezone: Int?
    let dt_txt: String?
    let cod: Int
}
