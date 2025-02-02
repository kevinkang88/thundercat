//
//  WeatherViewModel.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 1/31/25.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var weather: WeatherResponse?
    @Published var searchedWeather: [WeatherResponse]?
    @Published var isSearching: Bool = false

    private let weatherService: WeatherFetching
    private let persistenceManager: PersistenceManaging
    
    init(weatherService: WeatherFetching, persistenceManager: PersistenceManaging) {
        self.weatherService = weatherService
        self.persistenceManager = persistenceManager
        loadSavedWeather()
    }

    func searchWeather() async {
        guard !query.isEmpty else { return }
        
        do {
            let cities = try await weatherService.searchCities(query: query)
            searchedWeather = await fetchWeatherForCities(cities: cities)
        } catch {
            print("Error fetching weather: \(error)")
        }
    }

    private func fetchWeatherForCities(cities: [CitySearchResult]) async -> [WeatherResponse] {
        return await withTaskGroup(of: WeatherResponse?.self) { group in
            for city in cities {
                group.addTask {
                    return try? await self.weatherService.fetchWeatherForLocation(lat: city.lat, lon: city.lon)
                }
            }

            var results: [WeatherResponse] = []
            for await result in group {
                if let result = result {
                    results.append(result)
                }
            }
            return results
        }
    }

    func save(_ weather: WeatherResponse) {
        persistenceManager.saveWeather(weather)
        self.weather = weather
        isSearching = false
        resetSearch()
    }
    
    func resetSearch() {
        searchedWeather = nil
        query = ""
    }

    private func loadSavedWeather() {
        if let savedWeather = persistenceManager.loadWeather() {
            self.weather = savedWeather
        }
    }
}
