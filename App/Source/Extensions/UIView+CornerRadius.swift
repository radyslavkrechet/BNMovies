//
//  UIView+CornerRadius.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
