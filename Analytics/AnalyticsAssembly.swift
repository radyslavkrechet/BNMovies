//
//  AnalyticsAssembly.swift
//  Analytics
//
//  Created by Radyslav Krechet on 9/12/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Swinject

// There is no target/framework due errors
// https://github.com/CocoaPods/CocoaPods/issues/5768
struct AnalyticsAssembly: Assembly {
    init() {
        AnalyticsManager.setup()
    }

    func assemble(container: Container) {
        container.register(AnalyticsManagerProtocol.self) { _ in
            AnalyticsManager()
        }
    }
}
