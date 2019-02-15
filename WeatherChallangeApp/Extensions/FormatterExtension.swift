//
//  Formatter.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

extension Formatter {
    static var temperatureFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
}
