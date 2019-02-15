//
//  CityWeatherRequest.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

class CityWeatherRequest: BaseRequest {
    private let cityId: String

    init(urlPath: ApiUtils.ApiPath = .cityForecast, method: HTTPMethod = .get, cityId: String) {
        self.cityId = cityId
        super.init(urlPath: urlPath, method: method)
    }

    private enum ChildCodingKeys: String, CodingKey {
        case cityId = "id"
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildCodingKeys.self)
        try container.encodeIfPresent(cityId, forKey: .cityId)
        try super.encode(to: encoder)
    }
}
