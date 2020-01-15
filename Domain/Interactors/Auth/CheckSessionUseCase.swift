//
//  CheckSessionUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol CheckSessionUseCaseProtocol {
    func execute(_ handler: @escaping Handler<Bool>)
}

public class CheckSessionUseCase: CheckSessionUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.authRepository.isSignedIn(handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<Bool>!

    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    public func execute(_ handler: @escaping Handler<Bool>) {
        self.handler = handler
        execute()
    }
}
