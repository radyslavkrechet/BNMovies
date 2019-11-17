//
//  UserAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

enum UserAdapter {
    static func fromStorage(_ entity: UserEntity) -> User {
        return User(id: entity.id.value,
                    username: entity.username.value,
                    name: entity.name.value,
                    avatarSource: entity.avatarSource.value)
    }

    static func toStorage(_ user: User, _ entity: UserEntity) {
        entity.id.value = user.id
        entity.username.value = user.username
        entity.name.value = user.name
        entity.avatarSource.value = user.avatarSource
    }
}
