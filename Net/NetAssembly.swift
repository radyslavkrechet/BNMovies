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
    public init(with baseURL: String, apiKey: String) {
        ServerManager.setup(with: baseURL, apiKey: apiKey)
    }

    public func assemble(container: Container) {
        container.register(AuthAPIProtocol.self) { _ in
            AuthAPI()
        }.inObjectScope(.container)

        container.register(UserAPIProtocol.self) { _ in
            UserAPI()
        }.inObjectScope(.container)

        container.register(MovieAPIProtocol.self) { _ in
            MovieAPI()
        }.inObjectScope(.container)
    }
}
