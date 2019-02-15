//
//  ApiWorker.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

struct ApiWorker: ApiWorkerProtocol {
    public enum Result<Value> {
        case success(Value)
        case failure(Error)
    }

    public typealias ResultCallback<Value> = (Result<Value>) -> Void
    private static let successStatusCodes = Set([200])

    func fetchWeather(by cityId: String) -> Observable<ApiWorker.Result<Weather>> {
        return createCall(CityWeatherRequest(cityId: cityId), responseType: Weather.self)
    }
}

private extension ApiWorker {
    private var defaultHeaders: [String: String] {
        return [:]
    }

    func createCall<U: ApiRequestProtocol & BaseRequestProtocol, T: Decodable>(_ request: U, responseType: T.Type) -> Observable<Result<T>> {
        do {
            guard let targetURL = try request.urlPath.url.appendQueryParams(by: request.queryParams()) else {
                return Observable.just(Result.failure(ErrorWorker.ApiError.invalidAPIURL))
            }

            return RxAlamofire.requestData(request.method, targetURL, parameters: .none, encoding: URLEncoding.httpBody, headers: defaultHeaders).map { (urlResponse, data) -> Result<T> in
                NSLog("API CALL: End \(request.urlPath.url) with status code: \(urlResponse.statusCode)")
                if ApiWorker.successStatusCodes.contains(urlResponse.statusCode) {
                    do {
                        let encoder = JSONDecoder()
                        encoder.dateDecodingStrategy = .secondsSince1970
                        let response = try encoder.decode(responseType, from: data)
                        return Result.success(response)
                    } catch {
                        return Result.failure(ErrorWorker.ApiError.invalidResponse)
                    }
                } else {
                    return Result.failure(ErrorWorker.ApiError.businessError(urlResponse.statusCode))
                }
                }.catchError({ (error) -> Observable<Result<T>> in
                    return Observable.just(Result.failure(error))
                })
        } catch {
           return Observable.just(Result.failure(ErrorWorker.ApiError.invalidAPIURL))
        }
    }
}
