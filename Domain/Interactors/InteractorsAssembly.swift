//
//  InteractorsAssembly.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Swinject

public struct InteractorsAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        #if !os(tvOS)
        registerAuthInteractors(in: container)
        registerUserInteractors(in: container)
        #endif

        registerMovieInteractors(in: container)
    }

    #if !os(tvOS)
    private func registerAuthInteractors(in container: Container) {
        container.register(SignInUseCaseProtocol.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return SignInUseCase(authRepository: authRepository, userRepository: userRepository)
        }

        container.register(CheckSessionUseCaseProtocol.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            return CheckSessionUseCase(authRepository: authRepository)
        }

        container.register(SignOutUseCaseProtocol.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return SignOutUseCase(authRepository: authRepository, userRepository: userRepository)
        }
    }

    private func registerUserInteractors(in container: Container) {
        container.register(GetUserUseCaseProtocol.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return GetUserUseCase(authRepository: authRepository, userRepository: userRepository)
        }
    }
    #endif

    private func registerMovieInteractors(in container: Container) {
        container.register(GetChartUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetChartUseCase(movieRepository: movieRepository)
        }

        container.register(GetCollectionUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetCollectionUseCase(movieRepository: movieRepository)
        }

        container.register(GetMovieUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetMovieUseCase(movieRepository: movieRepository)
        }

        container.register(GetSimilarMoviesUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetSimilarMoviesUseCase(movieRepository: movieRepository)
        }

        container.register(ToggleMovieCollectionUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return ToggleMovieCollectionUseCase(movieRepository: movieRepository)
        }
    }
}
