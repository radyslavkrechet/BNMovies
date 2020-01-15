//
//  AuthRepositorySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Data

class AuthRepositorySpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var authRepository: AuthRepository!
        var authAPIMock: AuthAPIMock!
        var sessionDAOMock: SessionDAOMock!

        beforeEach {
            authAPIMock = AuthAPIMock()
            sessionDAOMock = SessionDAOMock()
            authRepository = AuthRepository(authAPI: authAPIMock, sessionDAO: sessionDAOMock)
        }

        describe("sign in") {
            let username = "username"
            let password = "password"

            context("auth api signs in -> error") {
                it("returns error") {
                    authAPIMock.settings.shouldReturnError = true

                    authRepository.signIn(with: username, password: password) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(authAPIMock.calls.signIn) == true
                        expect(authAPIMock.arguments.username) == username
                        expect(authAPIMock.arguments.password) == password
                    }
                }
            }

            context("auth api signs in -> session") {
                context("session dao sets session -> error") {
                    it("returns error") {
                        sessionDAOMock.settings.shouldReturnError = true

                        authRepository.signIn(with: username, password: password) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(authAPIMock.calls.signIn) == true
                            expect(authAPIMock.arguments.username) == username
                            expect(authAPIMock.arguments.password) == password
                            expect(sessionDAOMock.calls.set) == true
                        }
                    }
                }

                context("session dao sets session -> session") {
                    it("returns session") {
                        authRepository.signIn(with: username, password: password) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(authAPIMock.calls.signIn) == true
                            expect(authAPIMock.arguments.username) == username
                            expect(authAPIMock.arguments.password) == password
                            expect(sessionDAOMock.calls.set) == true
                        }
                    }
                }
            }
        }

        describe("get session") {
            context("session dao gets session -> error") {
                it("returns error") {
                    sessionDAOMock.settings.shouldReturnError = true

                    authRepository.getSession { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.getSession) == true
                    }
                }
            }

            context("session dao gets session -> session") {
                it("returns session") {
                    authRepository.getSession { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.getSession) == true
                    }
                }
            }
        }

        describe("is signed in") {
            context("session dao gets session -> error") {
                it("returns error") {
                    sessionDAOMock.settings.shouldReturnError = true

                    authRepository.isSignedIn { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.getSession) == true
                    }
                }
            }

            context("session dao gets session -> nil") {
                it("returns false") {
                    sessionDAOMock.settings.shouldReturnNil = true

                    authRepository.isSignedIn { result in
                        guard case .success(let isSignedIn) = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.getSession) == true
                        expect(isSignedIn) == false
                    }
                }
            }

            context("session dao gets session -> session") {
                it("returns true") {
                    authRepository.isSignedIn { result in
                        guard case .success(let isSignedIn) = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.getSession) == true
                        expect(isSignedIn) == true
                    }
                }
            }
        }

        describe("sign out") {
            context("session dao deletes session -> error") {
                it("returns error") {
                    sessionDAOMock.settings.shouldReturnError = true

                    authRepository.signOut { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.deleteSession) == true
                    }
                }
            }

            context("session dao deletes session -> void") {
                it("returns void") {
                    authRepository.signOut { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(sessionDAOMock.calls.deleteSession) == true
                    }
                }
            }
        }
    }
}
