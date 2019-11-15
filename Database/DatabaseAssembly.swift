//
//  DatabaseAssembly.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Data
import Swinject

public struct DatabaseAssembly: Assembly {
    public init() {
        DatabaseService.setup()
    }

    public func assemble(container: Container) {
        container.register(SessionDAOProtocol.self) { _ in
            SessionDAO()
        }.inObjectScope(.container)

        container.register(UserDAOProtocol.self) { _ in
            UserDAO()
        }.inObjectScope(.container)

        container.register(MovieDAOProtocol.self) { _ in
            MovieDAO()
        }.inObjectScope(.container)
    }
}
