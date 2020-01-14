//
//  MainModuleAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Swinject

struct MainModuleAssembly: Assembly {
    func assemble(container: Container) {
        registerPresenters(in: container)
        registerDataSources(in: container)
        initViewControllers(from: container)
    }

    private func registerPresenters(in container: Container) {
        container.register(HomePresenter.self) { resolver in
            let getMoviesUseCase = resolver.resolve(GetMoviesUseCaseProtocol.self)!
            return HomePresenter(getMoviesUseCase: getMoviesUseCase)
        }

        container.register(AccountPresenter.self) { resolver in
            let getUserUseCase = resolver.resolve(GetUserUseCaseProtocol.self)!
            let signOutUseCase = resolver.resolve(SignOutUseCaseProtocol.self)!
            return AccountPresenter(getUserUseCase: getUserUseCase, signOutUseCase: signOutUseCase)
        }

        container.register(MoviesPresenter.self) { resolver in
            let getFavouritesUseCase = resolver.resolve(GetFavouritesUseCaseProtocol.self)!
            let getWatchlistUseCase = resolver.resolve(GetWatchlistUseCaseProtocol.self)!
            return MoviesPresenter(getFavouritesUseCase: getFavouritesUseCase, getWatchlistUseCase: getWatchlistUseCase)
        }

        container.register(DetailsPresenter.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCaseProtocol.self)!
            let changeMovieFavouriteStateUseCase = resolver.resolve(ChangeMovieFavouriteStateUseCaseProtocol.self)!
            let changeMovieInWatchlistStateUseCase = resolver.resolve(ChangeMovieInWatchlistStateUseCaseProtocol.self)!
            return DetailsPresenter(getMovieUseCase: getMovieUseCase,
                                    changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCase,
                                    changeMovieInWatchlistStateUseCase: changeMovieInWatchlistStateUseCase)
        }

        container.register(SimilarMoviesPresenter.self) { resolver in
            let getSimilarMoviesUseCase = resolver.resolve(GetSimilarMoviesUseCaseProtocol.self)!
            return SimilarMoviesPresenter(getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        }
    }

    private func registerDataSources(in container: Container) {
        container.register(AccountDataSource.self) { _ in
            AccountDataSource()
        }

        container.register(MoviesDataSource.self) { _ in
            MoviesDataSource()
        }

        container.register(SimilarMoviesDataSource.self) { _ in
            SimilarMoviesDataSource()
        }
    }

    private func initViewControllers(from container: Container) {
        container.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(HomePresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }

        container.storyboardInitCompleted(AccountViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(AccountPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(AccountDataSource.self)!
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }

        container.storyboardInitCompleted(MoviesViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(MoviesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }

        container.storyboardInitCompleted(DetailsViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(DetailsPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }

        container.storyboardInitCompleted(SimilarMoviesViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(SimilarMoviesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(SimilarMoviesDataSource.self)!
            controller.analyticsService = resolver.resolve(AnalyticsServiceProtocol.self)
        }
    }
}
