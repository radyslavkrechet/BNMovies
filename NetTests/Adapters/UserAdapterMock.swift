//
//  UserAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

private enum Mock {
    static var user: User {
        User(id: "id", username: "username", name: "name", avatarSource: "avatarSource")
    }
}

class UserAdapterMock: UserAdapterProtocol {
    struct Calls {
        var toEntity = false
    }

    var calls = Calls()

    func toEntity(_ response: GetUserResponse) -> User {
        calls.toEntity = true
        return Mock.user
    }
}
