//
//  UIStoryboard+Navigation.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/30/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import SwinjectStoryboard

enum Storyboard: String {
    case Splash, SignIn, Main
}

extension UIStoryboard {
    static func set(_ name: Storyboard) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let storyboard = SwinjectStoryboard.create(name: name.rawValue,
                                                   bundle: nil,
                                                   container: delegate.dependencyInjectionManager.resolver)

        let viewController = storyboard.instantiateInitialViewController()

        guard let window = delegate.window else {
            delegate.window = UIWindow(frame: UIScreen.main.bounds)
            delegate.window?.rootViewController = viewController
            delegate.window?.makeKeyAndVisible()
            return
        }

        let duration = CATransaction.animationDuration()
        UIView.transition(with: window, duration: duration, options: .transitionCrossDissolve, animations: {
            let areAnimationsEnabled = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = viewController
            UIView.setAnimationsEnabled(areAnimationsEnabled)
        })
    }
}
