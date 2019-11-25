//
//  GetUserUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetUserUseCaseProtocol: Executable {
    func set(_ handler: @escaping Handler<User>) -> Self
}

public class GetUserUseCase: GetUserUseCaseProtocol, Workable {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private var handler: Handler<User>!

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    public func set(_ handler: @escaping Handler<User>) -> Self {
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        return self
    }

    func work() {
        authRepository.getSession { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): self.handler(.failure(error))
            case .success(let session):
                guard let session = session else {
                    self.handler(.failure(Session.Error.noValue))
                    return
                }

                self.userRepository.getUser(with: session.token, handler: self.handler)
            }
        }
    }
}
