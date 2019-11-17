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
        container.register(SignInUseCase.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return SignInUseCase(authRepository: authRepository, userRepository: userRepository)
        }

        container.register(CheckSessionUseCase.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            return CheckSessionUseCase(authRepository: authRepository)
        }

        container.register(SignOutUseCase.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return SignOutUseCase(authRepository: authRepository, userRepository: userRepository)
        }

        container.register(GetUserUseCase.self) { resolver in
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let userRepository = resolver.resolve(UserRepositoryProtocol.self)!
            return GetUserUseCase(authRepository: authRepository, userRepository: userRepository)
        }

        container.register(GetMoviesUseCase.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetMoviesUseCase(movieRepository: movieRepository)
        }

        container.register(GetFavouritesUseCase.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetFavouritesUseCase(movieRepository: movieRepository)
        }

        container.register(GetMovieUseCase.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetMovieUseCase(movieRepository: movieRepository)
        }

        container.register(GetSimilarMoviesUseCase.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return GetSimilarMoviesUseCase(movieRepository: movieRepository)
        }

        container.register(ChangeMovieFavouriteStateUseCase.self) { resolver in
            let movieRepository = resolver.resolve(MovieRepositoryProtocol.self)!
            return ChangeMovieFavouriteStateUseCase(movieRepository: movieRepository)
        }
    }
}
