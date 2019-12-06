//
//  UserAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol UserAdapterProtocol {
    func fromStorage(_ entity: UserEntity) -> User
    func toStorage(_ object: User, _ entity: UserEntity) -> UserEntity
}

struct UserAdapter: UserAdapterProtocol {
    func fromStorage(_ entity: UserEntity) -> User {
        return User(id: entity.id.value,
                    username: entity.username.value,
                    name: entity.name.value,
                    avatarSource: entity.avatarSource.value)
    }

    func toStorage(_ object: User, _ entity: UserEntity) -> UserEntity {
        entity.id.value = object.id
        entity.username.value = object.username
        entity.name.value = object.name
        entity.avatarSource.value = object.avatarSource
        return entity
    }
}
