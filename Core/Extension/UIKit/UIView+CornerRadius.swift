//
//  UIView+CornerRadius.swift
//  Core
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
}
