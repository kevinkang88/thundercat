//
//  CurrentWeatherView.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 2/2/25.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject private var viewModel = WeatherViewModel(
        weatherService: WeatherService(),
        persistenceManager: PersistenceManager()
    )

    var body: some View {
        NavigationStack {
            if viewModel.isSearching {
                if let weather = viewModel.searchedWeather {
                    VStack {
                        // cell
                        Button {
                            viewModel.saveWeather()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(weather.location.name)
                                        .font(.subheadline)
                                        .bold()
                                    Text("\(Int(weather.current.temp_c))°")
                                        .font(.largeTitle)
                                        .bold()
                                }
                                .padding(.horizontal)
                                Spacer()
                                AsyncImage(url: URL(string: "https:\(String(describing: weather.current.condition.icon))"))
                                    .frame(width: 80, height: 80)
                            }
                            .background(.gray.opacity(0.2))
                            .cornerRadius(15.0)
                            .padding()
                        }
                        Spacer()
                    }
                }

            } else {
                if let selectedCity = viewModel.weather {
                    VStack {
                        Text(selectedCity.location.name)
                            .font(.largeTitle)
                            .bold()
                        Text("\(Int(selectedCity.current.temp_c))°C - \(selectedCity.current.condition.text)")
                            .font(.title3)
                            .foregroundColor(.gray)
                        AsyncImage(url: URL(string: "https:\(selectedCity.current.condition.icon)"))
                            .frame(width: 80, height: 80)
                    }
                    .padding()
                } else {
                    Text("No City Selected")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
        }
        .searchable(
            text: $viewModel.query,
            isPresented: $viewModel.isSearching,
            placement: .automatic,
            prompt: "Search Location"
        )
        .textInputAutocapitalization(.never)
        .onSubmit(of: .search) {
            Task {
                await viewModel.searchWeather()
            }
            
        }
    }
}
