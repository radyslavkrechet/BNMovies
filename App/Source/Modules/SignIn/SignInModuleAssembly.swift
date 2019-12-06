//
//  SignInModuleAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Swinject

struct SignInModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignInPresenter.self) { resolver in
            let signInUseCase = resolver.resolve(SignInUseCaseProtocol.self)!
            return SignInPresenter(signInUseCase: signInUseCase)
        }

        container.storyboardInitCompleted(SignInViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(SignInPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }
    }
}
