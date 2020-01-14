//
//  UIWindow+Motion.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

#if DEBUG
extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DebuggingManager.toggleExplorer()
        }
    }
}
#endif
