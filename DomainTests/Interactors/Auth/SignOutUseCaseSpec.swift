//
//  SignOutUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class SignOutUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            context("auth repository returns error") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .failure)
                    let userRepository = UserRepositoryMock(settings: .failure)
                    let signOutUseCase = SignOutUseCase(authRepository: authRepository, userRepository: userRepository)

                    signOutUseCase.execute { result in
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
                    let signOutUseCase = SignOutUseCase(authRepository: authRepository, userRepository: userRepository)

                    signOutUseCase.execute { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("user repository returns void") {
                it("returns void") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: true))
                    let userRepository = UserRepositoryMock(settings: .success(isTruthy: true))
                    let signOutUseCase = SignOutUseCase(authRepository: authRepository, userRepository: userRepository)

                    signOutUseCase.execute { result in
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
