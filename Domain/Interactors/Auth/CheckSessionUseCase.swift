//
//  CheckSessionUseCase.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Foundation

public class CheckSessionUseCase: UseCase<Bool> {
    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    override func work(handler: @escaping Handler<Bool>) {
        authRepository.isSignedIn(handler: handler)
    }
}
