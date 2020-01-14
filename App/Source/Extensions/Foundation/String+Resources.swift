//
//  String+Resources.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var image: UIImage? {
        return UIImage(named: self)
    }
    var systemImage: UIImage? {
        return UIImage(systemName: self)
    }
    var color: UIColor? {
        return UIColor(named: self)
    }
}
