//
//  AppDelegate.swift
//  Movies
//
//  Created by Radyslav Krechet on 08.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit
import Core
import Domain
import Data
import Net
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var dependencyInjectionManager: DependencyInjectionManager!
    var window: UIWindow?

    override init() {
        if ProcessInfo.shouldLaunchApp {
            dependencyInjectionManager = DependencyInjectionManager()

            let net = NetAssembly(baseURL: dependencyInjectionManager.baseURL,
                                  apiKey: dependencyInjectionManager.apiKey)

            dependencyInjectionManager.apply(assembly: net)

            let repositories = RepositoriesAssembly()
            dependencyInjectionManager.apply(assembly: repositories)

            let interactors = InteractorsAssembly()
            dependencyInjectionManager.apply(assembly: interactors)

            let mainModule = MainModuleAssembly()
            dependencyInjectionManager.apply(assembly: mainModule)
        }

        super.init()
    }

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard ProcessInfo.shouldLaunchApp else {
            return false
        }

        let storyboard = SwinjectStoryboard.create(name: "Main",
                                                   bundle: nil,
                                                   container: dependencyInjectionManager.resolver)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
