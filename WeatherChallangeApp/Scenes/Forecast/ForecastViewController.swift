//
//  ForecastViewController.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol ForecastDisplayLogic: class {
    func showCityForecastSuccess(_ forecast: Weather)
    func showCityForecastFail(_ errorMessage: String)
}

class ForecastViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ForecastTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView()
            tableView.addSubview(refreshControl)
        }
    }

    private lazy var interactor: ForecastBusinessLogic & ForecastDataStore = ForecastInteractor(self)
    private lazy var router: ForecastRoutingLogic = ForecastRouter(resource: self, dataStore: interactor)

    private var disposeBag = DisposeBag()
    private let weatherDataSource = BehaviorRelay<Weather?>(value: .none)
    private let tableViewDataSource = BehaviorRelay<[SectionModel<Date, Forecast>]>(value: [])
    private let viewHeader = ForecastTableViewHeader()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Date, Forecast>>(
        configureCell: { (_, tableView, _, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier) as? ForecastTableViewCell else { return UITableViewCell() }
            cell.configureCell(by: element)
            return cell
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return DateFormatter.dateFormatter.string(from: dataSource[sectionIndex].model)
    })
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ForecastViewController.searchWeather), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToDataSource()
        searchWeather()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ForecastViewController: ForecastDisplayLogic {
    final func showCityForecastSuccess(_ forecast: Weather) {
        refreshControl.endRefreshing()
        weatherDataSource.accept(forecast)
    }

    final func showCityForecastFail(_ errorMessage: String) {
        refreshControl.endRefreshing()
        showAlert(by: errorMessage)
    }
}

private extension ForecastViewController {
    final func subscribeToDataSource() {
        weatherDataSource.asDriver().drive(onNext: { [weak self] (weather) in
            guard let wSelf = self else { return}
            guard let wWeather = weather else {
                wSelf.tableView.tableHeaderView = .none
                return
            }
            let parsedData = Dictionary(grouping: wWeather.forecast, by: { Calendar.current.startOfDay(for: $0.date) }).sorted(by: { $0.0 < $1.0 }).compactMap({ SectionModel(model: $0, items: $1.sorted(by: { $0.date < $1.date })) })
            wSelf.tableViewDataSource.accept(parsedData)
            wSelf.tableView.tableHeaderView = wSelf.viewHeader
            wSelf.viewHeader.setupView(by: wWeather)
        }).disposed(by: disposeBag)

        tableViewDataSource.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }

    @objc final func searchWeather() {
        interactor.searchWeatherForecast(by: Constant.selectedCityId)
    }
}

extension ForecastViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
