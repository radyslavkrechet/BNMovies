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
        container.register(MoviesDataSource.self) { _ in
            MoviesDataSource()
        }

        container.register(HomePresenter.self) { resolver in
            let getMoviesUseCase = resolver.resolve(GetMoviesUseCase.self)!
            return HomePresenter(getMoviesUseCase: getMoviesUseCase)
        }

        container.storyboardInitCompleted(HomeViewController<HomePresenter,
            MoviesDataSource>.self) { resolver, controller in

            controller.presenter = resolver.resolve(HomePresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(FavouritesPresenter.self) { resolver in
            let getFavouritesUseCase = resolver.resolve(GetFavouritesUseCase.self)!
            return FavouritesPresenter(getFavouritesUseCase: getFavouritesUseCase)
        }

        container.storyboardInitCompleted(FavouritesViewController<FavouritesPresenter,
            MoviesDataSource>.self) { resolver, controller in

            controller.presenter = resolver.resolve(FavouritesPresenter.self)!
            controller.presenter.view = controller
            controller.dataSource = resolver.resolve(MoviesDataSource.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(AccountPresenter.self) { resolver in
            let getUserUseCase = resolver.resolve(GetUserUseCase.self)!
            let signOutUseCase = resolver.resolve(SignOutUseCase.self)!
            return AccountPresenter(getUserUseCase: getUserUseCase, signOutUseCase: signOutUseCase)
        }

        container.storyboardInitCompleted(AccountViewController<AccountPresenter>.self) { resolver, controller in
            controller.presenter = resolver.resolve(AccountPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(DetailsPresenter.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCase.self)!
            let changeMovieFavouriteStateUseCase = resolver.resolve(ChangeMovieFavouriteStateUseCase.self)!
            return DetailsPresenter(getMovieUseCase: getMovieUseCase,
                                    changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCase)
        }

        container.storyboardInitCompleted(DetailsViewController<DetailsPresenter>.self) { resolver, controller in
            controller.presenter = resolver.resolve(DetailsPresenter.self)!
            controller.presenter.view = controller
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(SimilarMoviesPresenter.self) { resolver in
            let getSimilarMoviesUseCase = resolver.resolve(GetSimilarMoviesUseCase.self)!
            return SimilarMoviesPresenter(getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        }

        container.register(SimilarMoviesDataSource.self) { _ in
            SimilarMoviesDataSource()
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
