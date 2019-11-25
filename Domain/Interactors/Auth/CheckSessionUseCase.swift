//
//  CheckSessionUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol CheckSessionUseCaseProtocol: Executable {
    func set(_ handler: @escaping Handler<Bool>) -> Self
}

public class CheckSessionUseCase: CheckSessionUseCaseProtocol, Workable {
    private let authRepository: AuthRepositoryProtocol
    private var handler: Handler<Bool>!

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    public func set(_ handler: @escaping Handler<Bool>) -> Self {
        self.handler = handler
        return self
    }

    func work() {
        authRepository.isSignedIn(handler: handler)
    }
}
