//
//  WeatherService.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 1/31/25.
//

import Foundation

protocol WeatherFetching {
    func searchCities(query: String) async throws -> [CitySearchResult]
    func fetchWeatherForLocation(lat: Double, lon: Double) async throws -> WeatherResponse
}

class WeatherService: WeatherFetching {
    private let apiKey = ""

    func searchCities(query: String) async throws -> [CitySearchResult] {
        let urlString = "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(query)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([CitySearchResult].self, from: data)
    }
    
    func fetchWeatherForLocation(lat: Double, lon: Double) async throws -> WeatherResponse {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(lat),\(lon)"
        return try await fetchWeather(from: urlString)
    }
    
    private func fetchWeather(from urlString: String) async throws -> WeatherResponse {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
