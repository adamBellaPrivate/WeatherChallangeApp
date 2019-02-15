//
//  ForecastPresenter.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol ForecastPresentationLogic: class {
    func manageCityForecastSuccess(_ forecast: Weather)
    func manageCityForecastFail(_ errorMessage: String)
}

class ForecastPresenter {
    private weak var view: ForecastDisplayLogic?

    init(_ resourceView: ForecastDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ForecastPresenter: ForecastPresentationLogic {
    final func manageCityForecastSuccess(_ forecast: Weather) {
        view?.showCityForecastSuccess(forecast)
    }

    final func manageCityForecastFail(_ errorMessage: String) {
        view?.showCityForecastFail(errorMessage)
    }
}
