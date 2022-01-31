struct FixerResponse: Codable {
    let base: String
    var rates: [String: Double]
}
