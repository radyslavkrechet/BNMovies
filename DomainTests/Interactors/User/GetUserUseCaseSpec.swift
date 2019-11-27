//
//  GetUserUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 26.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetUserUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            context("auth repository returns error") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .failure)
                    let userRepository = UserRepositoryMock(settings: .failure)
                    let getUseUseCase = GetUserUseCase(authRepository: authRepository, userRepository: userRepository)

                    getUseUseCase.execute { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("auth repository returns nil") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: false))
                    let userRepository = UserRepositoryMock(settings: .failure)
                    let getUseUseCase = GetUserUseCase(authRepository: authRepository, userRepository: userRepository)

                    getUseUseCase.execute { result in
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
                    let getUseUseCase = GetUserUseCase(authRepository: authRepository, userRepository: userRepository)

                    getUseUseCase.execute { result in
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
                    let getUseUseCase = GetUserUseCase(authRepository: authRepository, userRepository: userRepository)

                    getUseUseCase.execute { result in
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
