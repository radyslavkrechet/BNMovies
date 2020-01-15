//
//  User.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public struct User: Identifiable, Equatable {
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
}
