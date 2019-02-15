//
//  UIViewExtension.swift
//  WeatherChallangeApp
//
//  Created by Adam Bella on 2/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func viewFromNibForClass(index: Int = 0) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[index] as? UIView
    }

    func initViewFromNib() {
        guard let view = viewFromNibForClass() else { return }
        addSubview(view)
        view.frame = bounds
    }
}
