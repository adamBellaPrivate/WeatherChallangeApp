//
//  City.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import MapKit

struct City: Codable {
    let identifier: Double
    let name: String
    let country: String
    let coordinate: CLLocationCoordinate2D?

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case lat
        case long = "lon"
        case coordinate = "coord"
        case country
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(coordinate?.latitude, forKey: .lat)
        try container.encodeIfPresent(coordinate?.longitude, forKey: .long)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decodeIfPresent(Double.self, forKey: .identifier) ?? -1
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        guard container.contains(.coordinate) else {
            coordinate = .none
            return
        }
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coordinate)
        guard let lat = try nestedContainer.decodeIfPresent(CLLocationDegrees.self, forKey: .lat), let long = try nestedContainer.decodeIfPresent(CLLocationDegrees.self, forKey: .long) else {
            coordinate = .none
            return
        }
        coordinate = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
    }
}
