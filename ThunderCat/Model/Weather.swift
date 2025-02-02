//
//  Weather.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 1/31/25.
//

import Foundation

struct WeatherResponse: Identifiable, Codable {
    let location: Location
    let current: CurrentWeather
    
    var id: String { "\(location.name),\(location.region)" }
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct CurrentWeather: Codable {
        let temperature: Double
        let feelsLike: Double
        let humidity: Int
        let uvIndex: Double?
        let condition: WeatherCondition
        let windDegree: Int

        enum CodingKeys: String, CodingKey {
            case temperature = "temp_f"
            case feelsLike = "feelslike_f"
            case humidity
            case uvIndex = "uv"
            case condition
            case windDegree = "wind_degree"
        }
    }
    
    struct WeatherCondition: Codable {
        let description: String
        let icon: String
    }
}
