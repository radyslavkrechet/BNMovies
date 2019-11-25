//
//  SignInUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol SignInUseCaseProtocol: Executable {
    func set(_ username: String, password: String, handler: @escaping Handler<User>) -> Self
}

public class SignInUseCase: SignInUseCaseProtocol, Workable {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private var username: String!
    private var password: String!
    private var handler: Handler<User>!

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    public func set(_ username: String, password: String, handler: @escaping Handler<User>) -> Self {
        self.username = username
        self.password = password
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        return self
    }

    func work() {
        authRepository.signIn(with: username, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): self.handler(.failure(error))
            case .success(let session): self.userRepository.getUser(with: session.token, handler: self.handler)
            }
        }
    }
}
