//
//  UserRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class UserRepositoryMock: UserRepositoryProtocol {
    var settings: MockSettings

    private let userMock = User(id: "id", username: "username", name: "name", avatarSource: "avatarSource")

    init(settings: MockSettings) {
        self.settings = settings
    }

    func getUser(with token: String, handler: @escaping Handler<User>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(userMock))
        }
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(()))
        }
    }
}
