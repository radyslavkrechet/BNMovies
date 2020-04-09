//
//  DependencyInjectionManager.swift
//  Core
//
//  Created by Radyslav Krechet on 09.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Swinject

private let file = (name: "Info", type: "plist")
private let keys = (baseURL: "Base URL", apiKey: "API Key")

public struct DependencyInjectionManager {
    public let baseURL: String
    public let apiKey: String

    public var resolver: Resolver {
        return assembler.resolver
    }

    private let assembler = Assembler()

    public init() {
        guard let path = Bundle.main.path(forResource: file.name, ofType: file.type),
            let properties = NSDictionary(contentsOfFile: path) as? [String: Any],
            let baseURL = properties[keys.baseURL] as? String,
            let apiKey = properties[keys.apiKey] as? String else {

                preconditionFailure("Failed to load server configs")
        }

        self.baseURL = baseURL
        self.apiKey = apiKey

        disableLogging()
    }

    public func apply(assembly: Assembly) {
        assembler.apply(assembly: assembly)
    }

    public func apply(assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }

    private func disableLogging() {
        // Disable logging due errors
        // https://github.com/Swinject/Swinject/issues/218
        Container.loggingFunction = nil
    }
}
