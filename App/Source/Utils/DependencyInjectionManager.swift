//
//  DependencyInjectionManager.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/30/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Net
import Database
import Swinject

private let file = (name: "Info", type: "plist")
private let keys = (baseURL: "Base URL", apiKey: "API Key")

struct DependencyInjectionManager {
    var resolver: Resolver {
        return assembler.resolver
    }

    private let assembler = Assembler()

    init() {
        guard let path = Bundle.main.path(forResource: file.name, ofType: file.type),
            let properties = NSDictionary(contentsOfFile: path) as? [String: Any],
            let baseURL = properties[keys.baseURL] as? String,
            let apiKey = properties[keys.apiKey] as? String else {

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
        #if RELEASE && PRODUCTION
        let analytics = AnalyticsAssembly()
        assembler.apply(assembly: analytics)
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
