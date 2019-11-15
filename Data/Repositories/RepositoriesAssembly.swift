//
//  RepositoriesAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Swinject

public struct RepositoriesAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(AuthRepositoryProtocol.self) { resolver in
            let authAPI = resolver.resolve(AuthAPIProtocol.self)!
            let sessionDAO = resolver.resolve(SessionDAOProtocol.self)!
            return AuthRepository(authAPI: authAPI, sessionDAO: sessionDAO)
        }.inObjectScope(.container)

        container.register(UserRepositoryProtocol.self) { resolver in
            let userAPI = resolver.resolve(UserAPIProtocol.self)!
            let userDAO = resolver.resolve(UserDAOProtocol.self)!
            return UserRepository(userAPI: userAPI, userDAO: userDAO)
        }.inObjectScope(.container)

        container.register(MovieRepositoryProtocol.self) { resolver in
            let movieAPI = resolver.resolve(MovieAPIProtocol.self)!
            let movieDAO = resolver.resolve(MovieDAOProtocol.self)!
            return MovieRepository(movieAPI: movieAPI, movieDAO: movieDAO)
        }.inObjectScope(.container)
    }
}
