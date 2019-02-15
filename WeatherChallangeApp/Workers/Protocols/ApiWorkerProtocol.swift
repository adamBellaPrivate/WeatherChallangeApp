//
//  ApiWorkerProtocol.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiWorkerProtocol {
    func fetchWeather(by cityId: String) -> Observable<ApiWorker.Result<Weather>>
}
