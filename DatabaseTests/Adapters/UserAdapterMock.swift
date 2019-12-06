//
//  UserAdapterMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

class UserAdapterMock: UserAdapterProtocol {
    struct Calls {
        var fromStorage = false
        var toStorage = false
    }

    var calls = Calls()

    func fromStorage(_ entity: UserEntity) -> User {
        calls.fromStorage = true
        return Mock.userObject
    }

    func toStorage(_ object: User, _ entity: UserEntity) -> UserEntity {
        calls.toStorage = true
        return Mock.userEntity
    }
}
