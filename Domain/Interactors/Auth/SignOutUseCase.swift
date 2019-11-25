//
//  SignOutUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol SignOutUseCaseProtocol: Executable {
    func set(_ handler: @escaping Handler<Void>) -> Self
}

public class SignOutUseCase: SignOutUseCaseProtocol, Workable {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private var handler: Handler<Void>!

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    public func set(_ handler: @escaping Handler<Void>) -> Self {
        self.handler = handler
        return self
    }

    func work() {
        authRepository.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure: self.handler(result)
            case .success: self.userRepository.deleteUser(handler: self.handler)
            }
        }
    }
}
