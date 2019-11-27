//
//  SignInUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class SignInUseCaseSpec: QuickSpec {
    private let username = "username"
    private let password = "password"

    override func spec() {
        describe("execute") {
            context("auth repository returns error") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .failure)
                    let userRepository = UserRepositoryMock(settings: .failure)
                    let signInUseCase = SignInUseCase(authRepository: authRepository, userRepository: userRepository)

                    signInUseCase.execute(with: self.username, password: self.password) { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("user repository returns error") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: true))
                    let userRepository = UserRepositoryMock(settings: .failure)
                    let signInUseCase = SignInUseCase(authRepository: authRepository, userRepository: userRepository)

                    signInUseCase.execute(with: self.username, password: self.password) { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("user repository returns user") {
                it("returns user") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: true))
                    let userRepository = UserRepositoryMock(settings: .success(isTruthy: true))
                    let signInUseCase = SignInUseCase(authRepository: authRepository, userRepository: userRepository)

                    signInUseCase.execute(with: self.username, password: self.password) { result in
                        switch result {
                        case .failure: fail()
                        case .success: pass()
                        }
                    }
                }
            }
        }
    }
}
