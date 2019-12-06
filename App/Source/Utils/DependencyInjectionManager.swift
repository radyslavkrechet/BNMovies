//
//  DependencyInjectionManager.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/30/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Net
import Database
import Swinject

private let keys = (baseURL: "Base URL", apiKey: "API Key")

struct DependencyInjectionManager {
    var resolver: Resolver {
        return assembler.resolver
    }

    private let assembler = Assembler()

    init(serverSource: [String: Any]) {
        guard let baseURL = serverSource[keys.baseURL] as? String,
            let apiKey = serverSource[keys.apiKey] as? String else {

                preconditionFailure("Failed to load server configs")
        }

        disableLogging()
        applyAssemblies(with: baseURL, apiKey: apiKey)
    }

    private func disableLogging() {
        // Disable logging due errors
        // https://github.com/Swinject/Swinject/issues/218
        Container.loggingFunction = nil
    }

    private func applyAssemblies(with baseURL: String, apiKey: String) {
        #if RELEASE
            // Setup Firebase for Crashlytics only
            let analytics = AnalyticsAssembly()
            #if PRODUCTION
                // Inject AnalyticsManager into the app
                assembler.apply(assembly: analytics)
            #endif
        #endif

        let net = NetAssembly(baseURL: baseURL, apiKey: apiKey)
        assembler.apply(assembly: net)

        let database = DatabaseAssembly()
        assembler.apply(assembly: database)

        let repositories = RepositoriesAssembly()
        assembler.apply(assembly: repositories)

        let interactors = InteractorsAssembly()
        assembler.apply(assembly: interactors)

        let splashModule = SplashModuleAssembly()
        let signInModule = SignInModuleAssembly()
        let mainModule = MainModuleAssembly()
        let modules: [Assembly] = [splashModule, signInModule, mainModule]
        assembler.apply(assemblies: modules)
    }
}
