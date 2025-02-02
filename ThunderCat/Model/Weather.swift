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
        let temp_c: Double
        let humidity: Int
        let uv: Double?
        let condition: WeatherCondition
    }
    
    struct WeatherCondition: Codable {
        let text: String
        let icon: String
    }
}
