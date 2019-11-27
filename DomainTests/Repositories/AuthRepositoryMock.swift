//
//  AuthRepositoryMock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class AuthRepositoryMock: AuthRepositoryProtocol {
    var settings: MockSettings

    private let sessionMock = Session(token: "token")

    init(settings: MockSettings) {
        self.settings = settings
    }

    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(sessionMock))
        }
    }

    func getSession(handler: @escaping Handler<Session?>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success(let isTruthy): handler(.success(isTruthy ? sessionMock : nil))
        }
    }

    func isSignedIn(handler: @escaping Handler<Bool>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success(let isTruthy): handler(.success(isTruthy))
        }
    }

    func signOut(handler: @escaping Handler<Void>) {
        switch settings {
        case .failure: handler(.failure(MockError.force))
        case .success: handler(.success(()))
        }
    }
}
