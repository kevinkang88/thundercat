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
            HStack {
                Text(weather.location.name)
                    .font(.title)
                    .bold()
                WindDirectionView(windDegree: weather.current.windDegree)
            }

            Text("\(Int(weather.current.temperature))°")
                .font(.largeTitle)
                .bold()
            WeatherStatsView(
                humidity: weather.current.humidity,
                uvIndex: weather.current.uvIndex,
                feelsLike: weather.current.feelsLike
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
        VStack(spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundColor(.black.opacity(0.3))
            Text(value)
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
        }
    }
}

struct WindDirectionView: View {
    let windDegree: Int

    var body: some View {
        Image(systemName: "location.north.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 21, height: 21)
            .rotationEffect(.degrees(Double(windDegree)))
            .foregroundColor(.black)
    }
}
