//
//  UIViewControllerExtension.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(by message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: .none)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: .none)
    }
}
