//
//  AppDelegate.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let dependencyInjectionManager: DependencyInjectionManager
    var window: UIWindow?

    override init() {
        dependencyInjectionManager = DependencyInjectionManager(serverSource: PropertyListService.properties)

        super.init()
    }

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
        DebuggingManager.setup()
        #endif

        AppearanceService.setup()
        UIStoryboard.set(.Splash)

        return true
    }
}
