//
//  AuthAPISpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class AuthAPISpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var signInAPIMock: SignInAPIMock!
        var authAPI: AuthAPI!

        beforeEach {
            signInAPIMock = SignInAPIMock()
            authAPI = AuthAPI(signInAPI: signInAPIMock)
        }

        describe("sign in") {
            let username = "username"
            let password = "password"

            context("sign in api creates token -> error") {
                it("returns error") {
                    signInAPIMock.settings.shouldReturnError = true

                    authAPI.signIn(with: username, password: password) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(signInAPIMock.calls.createToken) == true
                    }
                }
            }

            context("sign in api creates token -> token") {
                context("sign in api validates token -> error") {
                    it("returns error") {
                        signInAPIMock.settings.shouldReturnError = true
                        signInAPIMock.settings.errorIndex = 1

                        authAPI.signIn(with: username, password: password) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(signInAPIMock.calls.createToken) == true
                            expect(signInAPIMock.calls.validate) == true
                            expect(signInAPIMock.arguments.username) == username
                            expect(signInAPIMock.arguments.password) == password
                        }
                    }
                }

                context("sign in api validates token -> token") {
                    context("sign in api creates session -> error") {
                        it("returns error") {
                            signInAPIMock.settings.shouldReturnError = true
                            signInAPIMock.settings.errorIndex = 2

                            authAPI.signIn(with: username, password: password) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(signInAPIMock.calls.createToken) == true
                                expect(signInAPIMock.calls.validate) == true
                                expect(signInAPIMock.arguments.username) == username
                                expect(signInAPIMock.arguments.password) == password
                                expect(signInAPIMock.calls.createSession) == true
                            }
                        }
                    }

                    context("sign in api creates session -> session") {
                        it("returns session") {
                            authAPI.signIn(with: username, password: password) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(signInAPIMock.calls.createToken) == true
                                expect(signInAPIMock.calls.validate) == true
                                expect(signInAPIMock.arguments.username) == username
                                expect(signInAPIMock.arguments.password) == password
                                expect(signInAPIMock.calls.createSession) == true
                            }
                        }
                    }
                }
            }
        }
    }
}
