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
    // swiftlint:disable:next function_body_length
    override func spec() {
        var signInUseCase: SignInUseCase!
        var authRepositoryMock: AuthRepositoryMock!
        var userRepositoryMock: UserRepositoryMock!

        beforeEach {
            authRepositoryMock = AuthRepositoryMock()
            userRepositoryMock = UserRepositoryMock()
            signInUseCase = SignInUseCase(authRepository: authRepositoryMock, userRepository: userRepositoryMock)
        }

        describe("execute") {
            let username = "username"
            let password = "password"

            context("auth repository signs in -> error") {
                it("returns error") {
                    authRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        signInUseCase.execute(with: username, password: password) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authRepositoryMock.calls.signIn) == true
                            expect(authRepositoryMock.arguments.username) == username
                            expect(authRepositoryMock.arguments.password) == password
                            done()
                        }
                    }
                }
            }

            context("auth repository signs in -> session") {
                context("user repository gets user -> error") {
                    it("returns error") {
                        userRepositoryMock.settings.shouldReturnError = true

                        waitUntil { done in
                            signInUseCase.execute(with: username, password: password) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(authRepositoryMock.calls.signIn) == true
                                expect(authRepositoryMock.arguments.username) == username
                                expect(authRepositoryMock.arguments.password) == password
                                expect(userRepositoryMock.calls.getUser) == true
                                done()
                            }
                        }
                    }
                }

                context("user repository gets user -> user") {
                    it("returns user") {
                        waitUntil { done in
                            signInUseCase.execute(with: username, password: password) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(authRepositoryMock.calls.signIn) == true
                                expect(authRepositoryMock.arguments.username) == username
                                expect(authRepositoryMock.arguments.password) == password
                                expect(userRepositoryMock.calls.getUser) == true
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}
