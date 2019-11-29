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
            var checkSessionUseCase: CheckSessionUseCase!
            var authRepositoryMock: AuthRepositoryMock!

            beforeEach {
                authRepositoryMock = AuthRepositoryMock()
                checkSessionUseCase = CheckSessionUseCase(authRepository: authRepositoryMock)
            }

            context("auth repository checks session -> error") {
                it("returns error") {
                    authRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        checkSessionUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.isSignedIn) == true
                            done()
                        }
                    }
                }
            }

            context("auth repository checks session -> bool") {
                it("returns bool") {
                    waitUntil { done in
                        checkSessionUseCase.execute { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.isSignedIn) == true
                            done()
                        }
                    }
                }
            }
        }
    }
}
