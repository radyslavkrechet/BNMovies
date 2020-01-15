//
//  AppDelegate.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dependencyInjectionManager: DependencyInjectionManager!
    var window: UIWindow?

    override init() {
        if ProcessInfo.shouldLaunchApp {
            dependencyInjectionManager = DependencyInjectionManager()
        }

        super.init()
    }

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard ProcessInfo.shouldLaunchApp else {
            return false
        }

        #if DEBUG
        DebuggingManager.setup()
        #endif

        AppearanceService.setup()
        UIStoryboard.set(.Splash)

        return true
    }
}
