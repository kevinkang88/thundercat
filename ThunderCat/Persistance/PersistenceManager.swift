//
//  PersistenceManager.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 2/2/25.
//

import Foundation

protocol PersistenceManaging {
    func saveWeather(_ weather: WeatherResponse)
    func loadWeather() -> WeatherResponse?
}

class PersistenceManager: PersistenceManaging {
    private let userDefaultsKey = "SavedWeather"

    func saveWeather(_ weather: WeatherResponse) {
        if let data = try? JSONEncoder().encode(weather) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    func loadWeather() -> WeatherResponse? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return nil }
        return try? JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
