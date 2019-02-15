//
//  ApiRequestProtocol.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRequestProtocol {
    var urlPath: ApiUtils.ApiPath { get }
    var method: HTTPMethod {get}
}
