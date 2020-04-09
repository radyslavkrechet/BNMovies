//
//  MainModuleAssembly.swift
//  Movies
//
//  Created by Radyslav Krechet on 09.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Swinject

struct MainModuleAssembly: Assembly {
    func assemble(container: Container) {
        /*
        container.register(MoviesPresenter.self) { resolver in
            let getMoviesUseCase = resolver.resolve(GetChartUseCaseProtocol.self)!
            return MoviesPresenter(getMoviesUseCase: getMoviesUseCase)
        }

        container.register(DetailsPresenter.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCaseProtocol.self)!
            return DetailsPresenter(getMovieUseCase: getMovieUseCase)
        }

        container.register(MoviesDataSource.self) { _ in
            MoviesDataSource()
        }

        container.storyboardInitCompleted(MoviesViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(MoviesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
        }

        container.storyboardInitCompleted(DetailsViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(DetailsPresenter.self)!
            controller.presenter.view = controller
        }
 */
    }
}
