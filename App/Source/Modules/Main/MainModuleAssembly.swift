//
//  MainModuleAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Swinject

struct MainModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoviesTableProvider.self) { _ in
            MoviesTableProvider()
        }

        container.register(HomeViewModel.self) { resolver in
            let getMoviesUseCase = resolver.resolve(GetMoviesUseCase.self)!
            return HomeViewModel(getMoviesUseCase: getMoviesUseCase)
        }

        container.storyboardInitCompleted(HomeViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(HomeViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
            controller.recyclerProvider = resolver.resolve(MoviesTableProvider.self)!
        }

        container.register(FavouritesViewModel.self) { resolver in
            let getFavouritesUseCase = resolver.resolve(GetFavouritesUseCase.self)!
            return FavouritesViewModel(getFavouritesUseCase: getFavouritesUseCase)
        }

        container.storyboardInitCompleted(FavouritesViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(FavouritesViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
            controller.recyclerProvider = resolver.resolve(MoviesTableProvider.self)!
        }

        container.register(AccountViewModel.self) { resolver in
            let getUserUseCase = resolver.resolve(GetUserUseCase.self)!
            let signOutUseCase = resolver.resolve(SignOutUseCase.self)!
            return AccountViewModel(getUserUseCase: getUserUseCase, signOutUseCase: signOutUseCase)
        }

        container.storyboardInitCompleted(AccountViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(AccountViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(DetailsViewModel.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCase.self)!
            let changeMovieFavouriteStateUseCase = resolver.resolve(ChangeMovieFavouriteStateUseCase.self)!
            return DetailsViewModel(getMovieUseCase: getMovieUseCase,
                                    changeMovieFavouriteStateUseCase: changeMovieFavouriteStateUseCase)
        }

        container.storyboardInitCompleted(DetailsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(DetailsViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
        }

        container.register(SimilarMoviesCollectionProvider.self) { _ in
            SimilarMoviesCollectionProvider()
        }

        container.register(SimilarMoviesViewModel.self) { resolver in
            let getSimilarMoviesUseCase = resolver.resolve(GetSimilarMoviesUseCase.self)!
            return SimilarMoviesViewModel(getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        }

        container.storyboardInitCompleted(SimilarMoviesViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SimilarMoviesViewModel.self)!
            controller.analyticsManager = resolver.resolve(AnalyticsManagerProtocol.self)
            controller.recyclerProvider = resolver.resolve(SimilarMoviesCollectionProvider.self)!
        }
    }
}
