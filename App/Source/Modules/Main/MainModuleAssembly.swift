//
//  MainModuleAssembly.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
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
            let getMoviesUseCase = resolver.resolve(GetChartUseCaseProtocol.self)!
            return HomePresenter(getMoviesUseCase: getMoviesUseCase)
        }

        container.register(AccountPresenter.self) { resolver in
            let getUserUseCase = resolver.resolve(GetUserUseCaseProtocol.self)!
            let signOutUseCase = resolver.resolve(SignOutUseCaseProtocol.self)!
            return AccountPresenter(getUserUseCase: getUserUseCase, signOutUseCase: signOutUseCase)
        }

        container.register(CollectionPresenter.self) { resolver in
            let getCollectionUseCase = resolver.resolve(GetCollectionUseCaseProtocol.self)!
            return CollectionPresenter(getCollectionUseCase: getCollectionUseCase)
        }

        container.register(DetailsPresenter.self) { resolver in
            let getMovieUseCase = resolver.resolve(GetMovieUseCaseProtocol.self)!
            let toggleMovieCollectionUseCase = resolver.resolve(ToggleMovieCollectionUseCaseProtocol.self)!
            return DetailsPresenter(getMovieUseCase: getMovieUseCase,
                                    toggleMovieCollectionUseCase: toggleMovieCollectionUseCase)
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

        container.storyboardInitCompleted(CollectionViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(CollectionPresenter.self)!
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
