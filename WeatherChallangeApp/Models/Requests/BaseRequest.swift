//
//  BaseRequest.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

import Alamofire

protocol BaseRequestProtocol {
    func queryParams() -> [String: Any]
    func ignoredKeys() -> [String]
}

extension BaseRequest: BaseRequestProtocol {
    final func queryParams() -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard var parsedDict = json as? [String: Any] else { return [:] }
            ignoredKeys().forEach({ parsedDict.removeValue(forKey: $0) })
            return parsedDict
        } catch {
            return [:]
        }
    }
}

class BaseRequest: Encodable, ApiRequestProtocol {
    let urlPath: ApiUtils.ApiPath
    let method: HTTPMethod
    private let appId = Constant.weatherApiId
    private let units = Constant.selectedUnits

    init(urlPath: ApiUtils.ApiPath, method: HTTPMethod) {
        self.urlPath = urlPath
        self.method = method
    }

    enum CodingKeys: String, CodingKey {
        case urlPath
        case method
        case appId = "appid"
        case units
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(urlPath.url.asURL(), forKey: .urlPath)
        try container.encode(method.rawValue, forKey: .method)
        try container.encode(appId, forKey: .appId)
        try container.encode(units.rawValue, forKey: .units)
    }

    func ignoredKeys() -> [String] {
        return ["urlPath", "method"]
    }
}
