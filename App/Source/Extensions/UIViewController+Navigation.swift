//
//  UIViewController+Navigation.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

enum Segue: String {
    case Details
}

extension UIViewController {
    func present(_ segue: Segue, with sender: Any? = nil) {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}
