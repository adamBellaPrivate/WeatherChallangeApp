//
//  ForecastTableViewCell.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import Kingfisher

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblTime: UILabel!
    @IBOutlet private weak var lblMinTempValue: UILabel!
    @IBOutlet private weak var lblMinTempDesc: UILabel! {
        didSet {
            lblMinTempDesc.text = "screen.forecast.default_cell.min.desc".localized
        }
    }
    @IBOutlet private weak var lblCurrentTempValue: UILabel!
    @IBOutlet private weak var lblCurrentTempDesc: UILabel! {
        didSet {
            lblCurrentTempDesc.text = "screen.forecast.default_cell.current.desc".localized
        }
    }
    @IBOutlet private weak var lblMaxTempValue: UILabel!
    @IBOutlet private weak var lblMaxTempDesc: UILabel! {
        didSet {
            lblMaxTempDesc.text = "screen.forecast.default_cell.max.desc".localized
        }
    }
    @IBOutlet private weak var imgWeather: UIImageView!
    @IBOutlet private weak var lblPressureValue: UILabel!
    @IBOutlet private weak var lblPressureDesc: UILabel! {
        didSet {
            lblPressureDesc.text = "screen.forecast.default_cell.pressure.desc".localized
        }
    }
    @IBOutlet private weak var lblHumidityValue: UILabel!
    @IBOutlet private weak var lblHumidityDesc: UILabel! {
        didSet {
            lblHumidityDesc.text = "screen.forecast.default_cell.humidity.desc".localized
        }
    }

    final func configureCell(by forecast: Forecast) {
        lblTime.text = DateFormatter.timeFormatter.string(from: forecast.date)
        lblMinTempValue.text = formatTemperature(forecast.main.tempMin)
        lblCurrentTempValue.text = formatTemperature(forecast.main.temp)
        lblMaxTempValue.text = formatTemperature(forecast.main.tempMax)

        if let pressure = forecast.main.pressure {
            lblPressureValue.text = "\(pressure) hPa"
        } else {
            lblPressureValue.text = "-"
        }

        if let humidity = forecast.main.humidity {
            lblHumidityValue.text = "\(humidity) %"
        } else {
            lblHumidityValue.text = "-"
        }

        if let url = forecast.currentWeatherIconURL {
            imgWeather.kf.setImage(with: url)
        } else {
            imgWeather.image = .none
        }
    }
}

private extension ForecastTableViewCell {
    final func formatTemperature(_ temp: Double?) -> String? {
        guard let wTemp = temp, let formattedTemp = Formatter.temperatureFormatter.string(from: NSNumber(value: wTemp)) else { return "-" }
        return "\(formattedTemp) \(Constant.selectedUnits.denoted())"
    }
}
