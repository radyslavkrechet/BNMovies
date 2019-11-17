//
//  AppearanceService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

private let tintColorName = "Brand"

enum AppearanceService {
    static func setup() {
        UIView.appearance().tintColor = UIColor(named: tintColorName)
    }
}
