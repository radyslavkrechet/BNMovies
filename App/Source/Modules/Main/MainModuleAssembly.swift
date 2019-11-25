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

        container.register(FavouritesPresenter.self) { resolver in
            let getFavouritesUseCase = resolver.resolve(GetFavouritesUseCaseProtocol.self)!
            return FavouritesPresenter(getFavouritesUseCase: getFavouritesUseCase)
        }

        container.register(AccountPresenter.self) { resolver in
            let getUserUseCase = resolver.resolve(GetUserUseCaseProtocol.self)!
            let signOutUseCase = resolver.resolve(SignOutUseCaseProtocol.self)!
            return AccountPresenter(getUserUseCase: getUserUseCase, signOutUseCase: signOutUseCase)
        }

        container.register(DetailsPresenter.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCaseProtocol.self)!
            let changeMovieFavouriteStateUseCase = resolver.resolve(ChangeMovieFavouriteStateUseCaseProtocol.self)!
            return DetailsPresenter(getMovieUseCase: getMovieUseCase,
                                    changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCase)
        }

        container.register(SimilarMoviesPresenter.self) { resolver in
            let getSimilarMoviesUseCase = resolver.resolve(GetSimilarMoviesUseCaseProtocol.self)!
            return SimilarMoviesPresenter(getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        }
    }

    private func registerDataSources(in container: Container) {
        container.register(MoviesDataSource.self) { _ in
            MoviesDataSource()
        }

        container.register(SimilarMoviesDataSource.self) { _ in
            SimilarMoviesDataSource()
        }
    }

    private func initViewControllers(from container: Container) {
        container.storyboardInitCompleted(HomeViewController<HomePresenter,
            MoviesDataSource>.self) { resolver, controller in

            controller.presenter = resolver.resolve(HomePresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.storyboardInitCompleted(FavouritesViewController<FavouritesPresenter,
            MoviesDataSource>.self) { resolver, controller in

            controller.presenter = resolver.resolve(FavouritesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.storyboardInitCompleted(AccountViewController<AccountPresenter>.self) { resolver, controller in
            controller.presenter = resolver.resolve(AccountPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.storyboardInitCompleted(DetailsViewController<DetailsPresenter>.self) { resolver, controller in
            controller.presenter = resolver.resolve(DetailsPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.storyboardInitCompleted(SimilarMoviesViewController<SimilarMoviesPresenter,
            SimilarMoviesDataSource>.self) { resolver, controller in

            controller.presenter = resolver.resolve(SimilarMoviesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(SimilarMoviesDataSource.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }
    }
}
