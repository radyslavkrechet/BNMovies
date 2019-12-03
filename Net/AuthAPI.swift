//
//  AuthAPI.swift
//  Net
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data

class AuthAPI: AuthAPIProtocol {
    private let signInAPI: SignInAPIProtocol

    init(signInAPI: SignInAPIProtocol) {
        self.signInAPI = signInAPI
    }

    func signIn(with username: String, password: String, handler: @escaping Handler<Session>) {
        signInAPI.createToken { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let requestToken):
                self.signInAPI.validate(requestToken: requestToken, username: username, password: password) { result in
                    switch result {
                    case .failure(let error): handler(.failure(error))
                    case .success(let requestToken): self.signInAPI.createSession(with: requestToken, handler: handler)
                    }
                }
            }
        }
    }
}
