//
//  InteractorsAssembly.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Swinject

public struct InteractorsAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
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

        container.register(GetUserUseCaseProtocol.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return GetUserUseCase(authRepository: authRepository, userRepository: userRepository)
        }

        container.register(GetMoviesUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetMoviesUseCase(movieRepository: movieRepository)
        }

        container.register(GetFavouritesUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetFavouritesUseCase(movieRepository: movieRepository)
        }

        container.register(GetMovieUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetMovieUseCase(movieRepository: movieRepository)
        }

        container.register(GetSimilarMoviesUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetSimilarMoviesUseCase(movieRepository: movieRepository)
        }

        container.register(ChangeMovieFavouriteStateUseCaseProtocol.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return ChangeMovieFavouriteStateUseCase(movieRepository: movieRepository)
        }
    }
}
