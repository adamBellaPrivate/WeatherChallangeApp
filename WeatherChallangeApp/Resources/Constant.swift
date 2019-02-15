//
//  Constant.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct Constant {
    static let selectedCityId = "5128638"
    static let selectedUnits = TemperatureUnits.metric
    static let weatherApiId = "a2d79cf93043a0cb640cc348585e338b"

    struct ApplicationURLs {
        static let baseURL = URL(string: "http://api.openweathermap.org/data/2.5/")!
        static let iconResourcePath = "http://openweathermap.org/img/w/%@.png"
    }

    enum TemperatureUnits: String {
        case standard
        case metric
        case imperial

        func denoted() -> String {
            switch self {
            case .metric: return "°C"
            case .imperial: return "°F"
            default: return "K"
            }
        }
    }
}
