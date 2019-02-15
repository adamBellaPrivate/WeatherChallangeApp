//
//  ForecastInteractor.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ProgressHUD

protocol ForecastBusinessLogic {
     func searchWeatherForecast(by cityId: String)
}

protocol ForecastDataStore: class {

}

class ForecastInteractor: ForecastDataStore {
    private var presenter: ForecastPresentationLogic?
    private let apiWorker: ApiWorkerProtocol = ApiWorker()
    private let errorWorker = ErrorWorker()
    private var disposeBag = DisposeBag()

    init(_ resourceView: ForecastDisplayLogic) {
        presenter = ForecastPresenter(resourceView)
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ForecastInteractor: ForecastBusinessLogic {
    final func searchWeatherForecast(by cityId: String) {
        ProgressHUD.show()
        apiWorker.fetchWeather(by: cityId).asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse)).drive(onNext: { [weak self] (result) in
            guard let wSelf = self else {return}
            ProgressHUD.dismiss()
            if case .success(let response) = result {
                 wSelf.presenter?.manageCityForecastSuccess(response)
            } else if case .failure(let error) = result {
                 wSelf.presenter?.manageCityForecastFail(wSelf.errorWorker.process(error: error))
            }
        }).disposed(by: disposeBag)
    }
}
