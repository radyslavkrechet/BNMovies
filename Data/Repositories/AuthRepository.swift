//
//  AuthRepository.swift
//  Data
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

class AuthRepository: AuthRepositoryProtocol {
    private let authAPI: AuthAPIProtocol
    private let sessionDAO: SessionDAOProtocol

    init(authAPI: AuthAPIProtocol, sessionDAO: SessionDAOProtocol) {
        self.authAPI = authAPI
        self.sessionDAO = sessionDAO
    }

    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        authAPI.signIn(with: username, password: password) { result in
            switch result {
            case .failure: handler(result)
            case .success(let session): self.sessionDAO.set(session, handler: handler)
            }
        }
    }

    func getSession(handler: @escaping Handler<Session?>) {
        sessionDAO.getSession(handler: handler)
    }

    func isSignedIn(handler: @escaping Handler<Bool>) {
        sessionDAO.getSession { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let session): handler(.success(session != nil))
            }
        }
    }

    func signOut(handler: @escaping Handler<Void>) {
        sessionDAO.deleteSession(handler: handler)
    }
}
