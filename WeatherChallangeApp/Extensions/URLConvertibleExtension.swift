//
//  URLConvertibleExtension.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

extension URLConvertible {
    func appendQueryParams(by params: [String: Any]) throws -> URLConvertible? {
        var queryItems = [URLQueryItem]()

        params.forEach({
            queryItems.append(URLQueryItem(name: $0.key, value: $0.value as? String))
        })

        var urlComponents = URLComponents(url: try self.asURL(), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        return try urlComponents?.asURL()
    }
}
