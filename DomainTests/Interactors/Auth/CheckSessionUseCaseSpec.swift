//
//  CheckSessionUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class CheckSessionUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            context("auth repository returns error") {
                it("returns error") {
                    let authRepository = AuthRepositoryMock(settings: .failure)
                    let checkSessionUseCase = CheckSessionUseCase(authRepository: authRepository)

                    checkSessionUseCase.execute { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("auth repository returns nil") {
                it("returns false") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: false))
                    let checkSessionUseCase = CheckSessionUseCase(authRepository: authRepository)

                    checkSessionUseCase.execute { result in
                        switch result {
                        case .failure: fail()
                        case .success(let isSignedIn): expect(isSignedIn) == false
                        }
                    }
                }
            }

            context("auth repository returns session") {
                it("returns true") {
                    let authRepository = AuthRepositoryMock(settings: .success(isTruthy: true))
                    let checkSessionUseCase = CheckSessionUseCase(authRepository: authRepository)

                    checkSessionUseCase.execute { result in
                        switch result {
                        case .failure: fail()
                        case .success(let isSignedIn): expect(isSignedIn) == true
                        }
                    }
                }
            }
        }
    }
}
