//
//  UserRepositorySpec.swift
//  DataTests
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Data

class UserRepositorySpec: QuickSpec {
    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func spec() {
        var userRepository: UserRepository!
        var userAPIMock: UserAPIMock!
        var userDAOMock: UserDAOMock!

        beforeEach {
            userAPIMock = UserAPIMock()
            userDAOMock = UserDAOMock()
            userRepository = UserRepository(userAPI: userAPIMock, userDAO: userDAOMock)
        }

        describe("get user") {
            let token = "token"

            context("user dao gets user -> error") {
                it("returns error") {
                    userDAOMock.settings.shouldReturnError = true

                    userRepository.getUser(with: token) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.getUser) == true
                    }
                }
            }

            context("user dao gets user -> nil, user api gets user -> error") {
                it("returns error") {
                    userDAOMock.settings.shouldReturnNil = true
                    userAPIMock.settings.shouldReturnError = true

                    userRepository.getUser(with: token) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.getUser) == true
                        expect(userAPIMock.calls.getUser) == true
                        expect(userAPIMock.arguments.token) == token
                    }
                }
            }

            context("user dao gets user -> nil, user api gets user -> user, user dao sets user -> error") {
                it("returns error") {
                    userDAOMock.settings.shouldReturnError = true
                    userDAOMock.settings.errorIndex = 1
                    userDAOMock.settings.shouldReturnNil = true

                    userRepository.getUser(with: token) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.getUser) == true
                        expect(userAPIMock.calls.getUser) == true
                        expect(userAPIMock.arguments.token) == token
                        expect(userDAOMock.calls.set) == true
                        expect(userDAOMock.arguments.user).toNot(beNil())
                    }
                }
            }

            context("user dao gets user -> nil, user api gets user -> user, user dao sets user -> user") {
                it("returns user") {
                    userDAOMock.settings.shouldReturnNil = true

                    userRepository.getUser(with: token) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.getUser) == true
                        expect(userAPIMock.calls.getUser) == true
                        expect(userAPIMock.arguments.token) == token
                        expect(userDAOMock.calls.set) == true
                        expect(userDAOMock.arguments.user).toNot(beNil())
                    }
                }
            }

            context("user dao gets user -> user, user api gets user -> error") {
                it("returns user, returns error") {
                    userAPIMock.settings.shouldReturnError = true

                    waitUntil { done in
                        var returnIndex = 0
                        userRepository.getUser(with: token) { result in
                            if returnIndex == 0 {
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                returnIndex += 1
                            } else {
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                expect(userAPIMock.calls.getUser) == true
                                expect(userAPIMock.arguments.token).toNot(beNil())
                                done()
                            }
                        }
                    }
                }
            }

            context("user dao gets user -> user, user api gets user -> user, user dao sets user -> error") {
                it("returns user, returns error") {
                    userDAOMock.settings.shouldReturnError = true
                    userDAOMock.settings.errorIndex = 1

                    waitUntil { done in
                        var returnIndex = 0
                        userRepository.getUser(with: token) { result in
                            if returnIndex == 0 {
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                returnIndex += 1
                            } else {
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                expect(userAPIMock.calls.getUser) == true
                                expect(userAPIMock.arguments.token).toNot(beNil())
                                expect(userDAOMock.calls.set) == true
                                expect(userDAOMock.arguments.user).toNot(beNil())
                                done()
                            }
                        }
                    }
                }
            }

            context("user dao gets user -> user, user api gets user -> user, user dao sets user -> user") {
                it("returns user, returns user") {
                    waitUntil { done in
                        var returnIndex = 0
                        userRepository.getUser(with: token) { result in
                            if returnIndex == 0 {
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                returnIndex += 1
                            } else {
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(userDAOMock.calls.getUser) == true
                                expect(userAPIMock.calls.getUser) == true
                                expect(userAPIMock.arguments.token).toNot(beNil())
                                expect(userDAOMock.calls.set) == true
                                expect(userDAOMock.arguments.user).toNot(beNil())
                                done()
                            }
                        }
                    }
                }
            }
        }

        describe("delete user") {
            context("user dao deletes user -> error") {
                it("returns error") {
                    userDAOMock.settings.shouldReturnError = true

                    userRepository.deleteUser { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.deleteUser) == true
                    }
                }
            }

            context("user dao deletes user -> void") {
                it("returns void") {
                    userRepository.deleteUser { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(userDAOMock.calls.deleteUser) == true
                    }
                }
            }
        }
    }
}
