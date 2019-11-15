//
//  GetUserUseCase.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public class GetUserUseCase: UseCase<User> {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    override func work(handler: @escaping Handler<User>) {
        authRepository.getSession { [weak self] result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let session):
                guard let session = session else {
                    handler(.failure(Session.Error.noValue))
                    return
                }

                self?.userRepository.getUser(with: session.token, handler: handler)
            }
        }
    }
}
