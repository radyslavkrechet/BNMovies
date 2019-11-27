//
//  SignOutUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol SignOutUseCaseProtocol {
    func execute(_ handler: @escaping Handler<Void>)
}

public class SignOutUseCase: SignOutUseCaseProtocol, Executable {
    lazy var work = {
        self.authRepository.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure: self.handler(result)
            case .success: self.userRepository.deleteUser(handler: self.handler)
            }
        }
    }

    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private var handler: Handler<Void>!

    init(authRepository: AuthRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }

    public func execute(_ handler: @escaping Handler<Void>) {
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
