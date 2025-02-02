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
        VStack {
            Text(weather.location.name)
                .font(.largeTitle)
                .bold()
            Text("\(Int(weather.current.temp_c))°C - \(weather.current.condition.text)")
                .font(.title3)
                .foregroundColor(.gray)
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)"))
                .frame(width: 80, height: 80)
        }
        .padding()
    }
}
