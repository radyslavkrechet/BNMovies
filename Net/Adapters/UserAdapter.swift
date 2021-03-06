//
//  UserAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

private let gravatarURL = "https://www.gravatar.com/avatar"

protocol UserAdapterProtocol {
    func toObject(_ response: GetUserResponse) -> User
}

struct UserAdapter: UserAdapterProtocol {
    func toObject(_ response: GetUserResponse) -> User {
        return User(id: String(response.id),
                    username: response.username,
                    name: response.name,
                    avatarSource: "\(gravatarURL)/\(response.avatar.gravatar.hash)")
    }
}
