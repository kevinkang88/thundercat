//
//  SelectedWeatherView.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 2/2/25.
//

import SwiftUI

struct SelectedWeatherView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)"))
                .frame(width: 123, height: 123)
            Text(weather.location.name)
                .font(.title)
                .bold()
            Text("\(Int(weather.current.temp_f))°")
                .font(.largeTitle)
                .bold()
            WeatherStatsView(
                humidity: weather.current.humidity,
                uvIndex: weather.current.uv,
                feelsLike: weather.current.feelslike_f
            )

        }
        .padding()
    }
}

struct WeatherStatsView: View {
    let humidity: Int
    let uvIndex: Double?
    let feelsLike: Double

    var body: some View {
        HStack {
            WeatherStatCell(title: "Humidity", value: "\(humidity)%")
            Spacer()
            WeatherStatCell(title: "UV", value: uvIndex != nil ? "\(Int(uvIndex!))" : "-")
            Spacer()
            WeatherStatCell(title: "Feels Like", value: "\(Int(feelsLike))°")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

struct WeatherStatCell: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.title3)
                .bold()
        }
    }
}
