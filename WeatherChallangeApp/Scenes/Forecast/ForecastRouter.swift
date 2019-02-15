//
//  ForecastRouter.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

protocol ForecastRoutingLogic {

}

private protocol ForecastDataPassing {
    var dataStore: ForecastDataStore? { get }
}

class ForecastRouter: ForecastDataPassing {
    private weak var viewController: (ForecastDisplayLogic & UIViewController)?
    fileprivate var dataStore: ForecastDataStore?

    init(resource: ForecastDisplayLogic & UIViewController, dataStore: ForecastDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ForecastRouter: ForecastRoutingLogic {

}

private extension ForecastRouter {

}
