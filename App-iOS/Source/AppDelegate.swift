//
//  AppDelegate.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/16/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import UIKit
import Core
import Domain
import Data
import Net
import Database
import Swinject

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

            let database = DatabaseAssembly()
            dependencyInjectionManager.apply(assembly: database)

            let repositories = RepositoriesAssembly()
            dependencyInjectionManager.apply(assembly: repositories)

            let interactors = InteractorsAssembly()
            dependencyInjectionManager.apply(assembly: interactors)

            let splashModule = SplashModuleAssembly()
            let signInModule = SignInModuleAssembly()
            let mainModule = MainModuleAssembly()
            let modules: [Assembly] = [splashModule, signInModule, mainModule]
            dependencyInjectionManager.apply(assemblies: modules)
        }

        super.init()
    }

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard ProcessInfo.shouldLaunchApp else {
            return false
        }

        AppearanceService.setup()
        UIStoryboard.set(.Splash)

        return true
    }
}
