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
                if let searchedWeathers = viewModel.searchedWeather {
                    if searchedWeathers.isEmpty {
                        VStack(alignment: .center) {
                            Text("No Results Found")
                                .font(.title)
                                .bold()
                        }
                    } else {
                        VStack {
                            ForEach(searchedWeathers) { weather in
                                WeatherSearchResultCell(weather: weather) {
                                    viewModel.save(weather)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                }

            } else {
                if let weather = viewModel.weather {
                    SelectedWeatherView(
                        weather: weather
                    )
                    .padding()
                } else {
                    VStack(alignment: .center, spacing: 15) {
                        Text("No City Selected")
                            .font(.title)
                            .bold()
                        Text("Please Search For A City")
                            .font(.subheadline)
                            .bold()
                    }
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
        .onChange(of: viewModel.isSearching) { _, isSearching in
            if !isSearching {
                viewModel.resetSearch()
            }
        }
    }
}
