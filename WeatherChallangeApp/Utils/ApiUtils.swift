//
//  ApiUtils.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

struct ApiUtils {
    enum ApiPath: String {
        case cityForecast = "forecast"

        var url: URLConvertible {
            return ApiUtils.apiURL(by: self.rawValue)
        }
    }
}

private extension ApiUtils {
    static func apiURL(by path: String) -> URLConvertible {
        return Constant.ApplicationURLs.baseURL.appendingPathComponent(path)
    }
}
