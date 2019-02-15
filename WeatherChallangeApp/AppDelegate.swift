//
//  AppDelegate.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/14/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialAppStarting()
        return true
    }

}

private extension AppDelegate {
    final func initialAppStarting() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ForecastViewController()
        window?.makeKeyAndVisible()
    }
}
