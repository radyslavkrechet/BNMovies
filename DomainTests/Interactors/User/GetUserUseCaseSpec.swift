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
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("execute") {
            var getUseUseCase: GetUserUseCase!
            var authRepositoryMock: AuthRepositoryMock!
            var userRepositoryMock: UserRepositoryMock!

            beforeEach {
                authRepositoryMock = AuthRepositoryMock()
                userRepositoryMock = UserRepositoryMock()
                getUseUseCase = GetUserUseCase(authRepository: authRepositoryMock, userRepository: userRepositoryMock)
            }

            context("auth repository gets session -> error") {
                it("returns error") {
                    authRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getUseUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.getSession) == true
                            done()
                        }
                    }
                }
            }

            context("auth repository gets session -> nil") {
                it("returns error") {
                    authRepositoryMock.settings.shouldReturnNil = true

                    waitUntil { done in
                        getUseUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.getSession) == true
                            done()
                        }
                    }
                }
            }

            context("auth repository gets session -> session, user repository gets user -> error") {
                it("returns error") {
                    userRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getUseUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.getSession) == true
                            expect(userRepositoryMock.calls.getUser) == true
                            done()
                        }
                    }
                }
            }

            context("auth repository gets session -> session, user repository gets user -> user") {
                it("returns user") {
                    waitUntil { done in
                        getUseUseCase.execute { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.getSession) == true
                            expect(userRepositoryMock.calls.getUser) == true
                            done()
                        }
                    }
                }
            }
        }
    }
}
