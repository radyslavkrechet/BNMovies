//
//  DatabaseAssembly.swift
//  Database
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import Swinject

public struct DatabaseAssembly: Assembly {
    public init() {
        DatabaseService.setup()
    }

    public func assemble(container: Container) {
        registerAdapter(in: container)
        registerDAO(in: container)
    }

    private func registerAdapter(in container: Container) {
        container.register(SessionAdapterProtocol.self) { _ in
            SessionAdapter()
        }

        container.register(UserAdapterProtocol.self) { _ in
            UserAdapter()
        }

        container.register(MovieAdapterProtocol.self) { resolver in
            let genreAdapter = resolver.resolve(GenreAdapterProtocol.self)!
            return MovieAdapter(genreAdapter: genreAdapter)
        }

        container.register(GenreAdapterProtocol.self) { _ in
            GenreAdapter()
        }
    }

    private func registerDAO(in container: Container) {
        container.register(SessionDAOProtocol.self) { resolver in
            let databaseManager = DatabaseManager<Session, SessionEntity>()
            let sessioAdapter = resolver.resolve(SessionAdapterProtocol.self)!
            return SessionDAO(databaseManager: databaseManager, sessionAdapter: sessioAdapter)
        }.inObjectScope(.container)

        container.register(UserDAOProtocol.self) { resolver in
            let databaseManager = DatabaseManager<User, UserEntity>()
            let userAdapter = resolver.resolve(UserAdapterProtocol.self)!
            return UserDAO(databaseManager: databaseManager, userAdapter: userAdapter)
        }.inObjectScope(.container)

        container.register(MovieDAOProtocol.self) { resolver in
            let databaseManager = DatabaseManager<Movie, MovieEntity>()
            let movieAdapter = resolver.resolve(MovieAdapterProtocol.self)!
            let genreDAO = resolver.resolve(GenreDAOProtocol.self)!
            return MovieDAO(databaseManager: databaseManager, movieAdapter: movieAdapter, genreDAO: genreDAO)
        }.inObjectScope(.container)

        container.register(GenreDAOProtocol.self) { resolver in
            let databaseManager = DatabaseManager<Genre, GenreEntity>()
            let genreAdapter = resolver.resolve(GenreAdapterProtocol.self)!
            return GenreDAO(databaseManager: databaseManager, genreAdapter: genreAdapter)
        }.inObjectScope(.container)
    }
}
