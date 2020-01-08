//
//  NetAssembly.swift
//  Net
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Data
import Swinject

public struct NetAssembly: Assembly {
    public init(baseURL: String, apiKey: String) {
        let serverSettings = ServerSettings(baseURL: baseURL, apiKey: apiKey)
        RouterService.setup(with: serverSettings)
    }

    public func assemble(container: Container) {
        registerAdapter(in: container)
        registerUtils(in: container)
        registerAPI(in: container)
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

    private func registerUtils(in container: Container) {
        container.register(CoderServiceProtocol.self) { _ in
            CoderService()
        }

        container.register(NetworkManagerProtocol.self) { _ in
            NetworkManager()
        }
    }

    private func registerAPI(in container: Container) {
        container.register(AuthAPIProtocol.self) { resolver in
            let signInAPI = resolver.resolve(SignInAPIProtocol.self)!
            return AuthAPI(signInAPI: signInAPI)
        }.inObjectScope(.container)

        container.register(SignInAPIProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
            let coderService = resolver.resolve(CoderServiceProtocol.self)!
            let sessionAdapter = resolver.resolve(SessionAdapterProtocol.self)!
            return SignInAPI(networkManager: networkManager, coderService: coderService, sessionAdapter: sessionAdapter)
        }.inObjectScope(.container)

        container.register(UserAPIProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
            let coderService = resolver.resolve(CoderServiceProtocol.self)!
            let userAdapter = resolver.resolve(UserAdapterProtocol.self)!
            return UserAPI(networkManager: networkManager, coderService: coderService, userAdapter: userAdapter)
        }.inObjectScope(.container)

        container.register(MovieAPIProtocol.self) { resolver in
            let networkManager = resolver.resolve(NetworkManagerProtocol.self)!
            let coderService = resolver.resolve(CoderServiceProtocol.self)!
            let movieAdapter = resolver.resolve(MovieAdapterProtocol.self)!
            return MovieAPI(networkManager: networkManager, coderService: coderService, movieAdapter: movieAdapter)
        }.inObjectScope(.container)
    }
}
