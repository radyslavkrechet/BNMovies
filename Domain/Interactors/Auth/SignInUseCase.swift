//
//  SignInUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class SignInUseCase: ParameterizableUseCase<User, SignInUseCase.Parameters> {
    public struct Parameters {
        let username: String
        let password: String

        public init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }

    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    override func work(handler: @escaping Handler<User>) {
        authRepository.signIn(with: parameters.username, password: parameters.password) { [weak self] result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let session): self?.userRepository.getUser(with: session.token, handler: handler)
            }
        }
    }
}
