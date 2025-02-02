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
    @Published var searchedWeather: WeatherResponse? // use other search endpoint and make this a list
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
            let fetchedWeather = try await weatherService.fetchWeather(for: query)
            searchedWeather = fetchedWeather
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
    
    func saveWeather() {
        if let searchedWeather {
            persistenceManager.saveWeather(searchedWeather)
            self.weather = searchedWeather
        }
    }

    private func loadSavedWeather() {
        if let savedWeather = persistenceManager.loadWeather() {
            self.weather = savedWeather
        }
    }
}
