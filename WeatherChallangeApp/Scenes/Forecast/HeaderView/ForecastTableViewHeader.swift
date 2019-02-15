//
//  ForecastTableViewHeader.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import MapKit

class ForecastTableViewHeader: UIView {
    private static let customHeaderHeight: CGFloat = 150

    @IBOutlet private weak var lblCityName: UILabel! {
        didSet {
            lblCityName.text = .none
        }
    }
    @IBOutlet private weak var map: MKMapView!

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ForecastTableViewHeader.customHeaderHeight))
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }

    // MARK: - Setup view
    final func setupView(by weather: Weather) {
        map.removeAnnotations(map.annotations)
        lblCityName.text = "\(weather.city.name) (\(weather.city.country))"

        guard let center = weather.city.coordinate else { return }
        let span = map.regionThatFits(MKCoordinateRegion(center: center, latitudinalMeters: 300000, longitudinalMeters: 300000)).span
        let region = MKCoordinateRegion(center: center, span: span)
        map.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        map.addAnnotation(annotation)
    }
}
