//
//  ErrorWorker.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct ErrorWorker {
    enum ApiError: Error {
        case invalidResponse
        case invalidAPIURL
        case businessError(Int)
    }

    func process(error err: Error) -> String {
        guard let apiError = err as? ApiError else { return err.localizedDescription }

        switch apiError {
        case .invalidResponse, .invalidAPIURL:
            return "general_error".localized
        case .businessError(let statusCode):
            return String(format: "business_error".localized, statusCode)
        }
    }
}
