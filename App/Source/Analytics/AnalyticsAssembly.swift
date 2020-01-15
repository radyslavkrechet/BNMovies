//
//  AnalyticsAssembly.swift
//  Analytics
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Swinject

// There is no target/framework due errors
// https://github.com/CocoaPods/CocoaPods/issues/5768
struct AnalyticsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AnalyticsManagerProtocol.self) { _ in
            AnalyticsManager()
        }

        container.register(AnalyticsServiceProtocol.self) { resolver in
            let analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)!
            return AnalyticsService(analyticsManager: analyticsManager)
        }
    }
}
