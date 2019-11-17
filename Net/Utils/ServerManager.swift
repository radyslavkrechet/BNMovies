//
//  ServerManager.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

struct ServerManager {
    static var shared = ServerManager()

    var baseURL: String {
        return ServerManager.baseURL
    }
    var apiKey: String {
        return ServerManager.apiKey
    }

    private static var baseURL: String!
    private static var apiKey: String!

    private init() {}

    static func setup(with baseURL: String, apiKey: String) {
        ServerManager.baseURL = baseURL
        ServerManager.apiKey = apiKey
    }
}
