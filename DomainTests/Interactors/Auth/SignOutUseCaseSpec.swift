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
            var signOutUseCase: SignOutUseCase!
            var authRepositoryMock: AuthRepositoryMock!
            var userRepositoryMock: UserRepositoryMock!

            beforeEach {
                authRepositoryMock = AuthRepositoryMock()
                userRepositoryMock = UserRepositoryMock()
                signOutUseCase = SignOutUseCase(authRepository: authRepositoryMock, userRepository: userRepositoryMock)
            }

            context("auth repository returns error") {
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

            context("user repository returns error") {
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

            context("user repository returns void") {
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
