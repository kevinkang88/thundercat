//
//  CitySearchResult.swift
//  ThunderCat
//
//  Created by Dong Kevin Kang on 2/2/25.
//

struct CitySearchResult: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double

    var uniqueID: String { "\(lat),\(lon)" }

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
    }
}
