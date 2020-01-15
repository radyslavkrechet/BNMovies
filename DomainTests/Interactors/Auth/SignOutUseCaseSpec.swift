//
//  SignOutUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class SignOutUseCaseSpec: QuickSpec {
    override func spec() {
        var signOutUseCase: SignOutUseCase!
        var authRepositoryMock: AuthRepositoryMock!
        var userRepositoryMock: UserRepositoryMock!

        beforeEach {
            authRepositoryMock = AuthRepositoryMock()
            userRepositoryMock = UserRepositoryMock()
            signOutUseCase = SignOutUseCase(authRepository: authRepositoryMock, userRepository: userRepositoryMock)
        }

        describe("execute") {
            context("auth repository signs out -> error") {
                it("returns error") {
                    authRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        signOutUseCase.execute { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.signOut) == true
                            done()
                        }
                    }
                }
            }

            context("auth repository signs out -> void") {
                context("user repository deletes user -> error") {
                    it("returns error") {
                        userRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            signOutUseCase.execute { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(authRepositoryMock.calls.signOut) == true
                                expect(userRepositoryMock.calls.deleteUser) == true
                                done()
                            }
                        }
                    }
                }

                context("user repository deletes user -> void") {
                    it("returns void") {
                        waitUntil { done in
                            signOutUseCase.execute { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(authRepositoryMock.calls.signOut) == true
                                expect(userRepositoryMock.calls.deleteUser) == true
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}
