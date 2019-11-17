//
//  SignOutUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public class SignOutUseCase: UseCase<Void> {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    override func work(handler: @escaping Handler<Void>) {
        authRepository.signOut { [weak self] result in
            switch result {
            case .failure: handler(result)
            case .success: self?.userRepository.deleteUser(handler: handler)
            }
        }
    }
}
