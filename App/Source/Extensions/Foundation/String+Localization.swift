//
//  String+Localization.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
