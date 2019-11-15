//
//  UIWindow+Motion.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import UIKit

#if DEBUG || STAGING
extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DebuggingService.toggleExplorer()
        }
    }
}
#endif
