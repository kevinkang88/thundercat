//
//  WeatherSearchResultCell.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 2/2/25.
//

import SwiftUI

struct WeatherSearchResultCell: View {
    let weather: WeatherResponse
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading) {
                    Text(weather.location.name)
                        .font(.subheadline)
                        .bold()
                    Text("\(Int(weather.current.temperature))°")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.horizontal)
                Spacer()
                AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)"))
                    .frame(width: 80, height: 80)
            }
            .background(.gray.opacity(0.2))
            .cornerRadius(15.0)
            .padding()
        }
    }
}
