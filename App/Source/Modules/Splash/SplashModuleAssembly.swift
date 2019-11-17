//
//  SplashModuleAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Swinject

struct SplashModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashViewModel.self) { resolver in
            let checkSessionUseCase = resolver.resolve(CheckSessionUseCase.self)!
            return SplashViewModel(checkSessionUseCase: checkSessionUseCase)
        }

        container.storyboardInitCompleted(SplashViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SplashViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }
    }
}
