//
//  FormatterExtension.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }

    static var timeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
}
