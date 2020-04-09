//
//  UIViewController+Navigation.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

enum Segue: String {
    case Collection, Details
}

extension UIViewController {
    func present(_ segue: Segue, with sender: Any? = nil) {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}
