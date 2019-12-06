//
//  UserAdapterMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

class UserAdapterMock: UserAdapterProtocol {
    struct Calls {
        var toObject = false
    }

    var calls = Calls()

    func toObject(_ response: GetUserResponse) -> User {
        calls.toObject = true
        return Mock.user
    }
}
