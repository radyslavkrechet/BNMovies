//
//  User.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public struct User: Equatable {
    public let id: String
    public let username: String
    public let name: String?
    public let avatarSource: String

    public init(id: String, username: String, name: String? = nil, avatarSource: String) {
        self.id = id
        self.username = username
        self.name = name
        self.avatarSource = avatarSource
    }

    // MARK: - Equatable

    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
            && lhs.username == rhs.username
            && lhs.name == rhs.name
            && lhs.avatarSource == rhs.avatarSource
    }
}
