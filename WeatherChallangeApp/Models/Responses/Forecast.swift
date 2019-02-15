//
//  Forecast.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let date: Date
    let main: MainData
    let weather: [WeatherData]

    var currentWeatherIconURL: URL? {
        guard let icon = weather.first?.icon else { return .none }
        let urlPath = String(format: Constant.ApplicationURLs.iconResourcePath, icon)
        return URL(string: urlPath)
    }

    private enum CodingKeys: String, CodingKey {
        case main
        case date = "dt"
        case weather
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(date, forKey: .date)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encodeIfPresent(weather, forKey: .weather)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        main = try container.decode(MainData.self, forKey: .main)
        date = try container.decode(Date.self, forKey: .date)
        weather = try container.decodeIfPresent([WeatherData].self, forKey: .weather) ?? []
    }
}

struct MainData: Codable {
    let temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Double?

    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temp, forKey: .temp)
        try container.encodeIfPresent(tempMin, forKey: .tempMin)
        try container.encodeIfPresent(tempMax, forKey: .tempMax)
        try container.encodeIfPresent(pressure, forKey: .pressure)
        try container.encodeIfPresent(humidity, forKey: .humidity)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decodeIfPresent(Double.self, forKey: .temp)
        tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
        tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
        pressure = try container.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)
    }
}

struct WeatherData: Codable {
    let identifier: Double
    let icon: String
    let main: String
    let desc: String

    private enum CodingKeys: String, CodingKey {
        case main
        case desc = "description"
        case icon
        case identifier = "id"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encodeIfPresent(desc, forKey: .desc)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(identifier, forKey: .identifier)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decodeIfPresent(Double.self, forKey: .identifier) ?? -1
        desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
        icon = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
        main = try container.decodeIfPresent(String.self, forKey: .main) ?? ""
    }
}
