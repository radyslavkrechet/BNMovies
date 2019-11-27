//
//  SignInUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol SignInUseCaseProtocol {
    func execute(with username: String, password: String, handler: @escaping Handler<User>)
}

public class SignInUseCase: SignInUseCaseProtocol, Executable {
    lazy var work = {
        self.authRepository.signIn(with: self.username, password: self.password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): self.handler(.failure(error))
            case .success(let session): self.userRepository.getUser(with: session.token, handler: self.handler)
            }
        }
    }

    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private var username: String!
    private var password: String!
    private var handler: Handler<User>!

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    public func execute(with username: String, password: String, handler: @escaping Handler<User>) {
        self.username = username
        self.password = password
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
