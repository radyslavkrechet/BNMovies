//
//  CheckSessionUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol CheckSessionUseCaseProtocol {
    func execute(_ handler: @escaping Handler<Bool>)
}

public class CheckSessionUseCase: CheckSessionUseCaseProtocol, Executable {
    lazy var work = {
        self.authRepository.isSignedIn(handler: self.handler)
    }

    private let authRepository: AuthRepositoryProtocol
    private var handler: Handler<Bool>!

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    public func execute(_ handler: @escaping Handler<Bool>) {
        self.handler = { result in DispatchQueue.main.async { handler(result) } }
        execute()
    }
}
