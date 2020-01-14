//
//  SplashModuleAssembly.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Swinject

struct SplashModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashPresenter.self) { resolver in
            let checkSessionUseCase = resolver.resolve(CheckSessionUseCaseProtocol.self)!
            return SplashPresenter(checkSessionUseCase: checkSessionUseCase)
        }

        container.storyboardInitCompleted(SplashViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(SplashPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }
    }
}
