//
//  WeatherService.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 1/31/25.
//

import Foundation

protocol WeatherFetching {
    func fetchWeather(for query: String) async throws -> WeatherResponse
}

class WeatherService: WeatherFetching {
    private let apiKey = ""
    
    func fetchWeather(for query: String) async throws -> WeatherResponse {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(query)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
