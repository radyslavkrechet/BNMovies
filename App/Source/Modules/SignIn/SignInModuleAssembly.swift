//
//  SignInModuleAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Swinject

struct SignInModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SignInViewModel.self) { resolver in
            let signInUseCase = resolver.resolve(SignInUseCase.self)!
            return SignInViewModel(signInUseCase: signInUseCase)
        }

        container.storyboardInitCompleted(SignInViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SignInViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }
    }
}
