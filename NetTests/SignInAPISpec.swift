//
//  SignInAPISpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class SignInAPISpec: QuickSpec {
    // swiftlint:disable:next function_body_length cyclomatic_complexity
    override func spec() {
        var networkManagerMock: NetworkManagerMock!
        var coderServiceMock: CoderServiceMock!
        var sessionAdapterMock: SessionAdapterMock!
        var signInAPI: SignInAPI!

        beforeEach {
            networkManagerMock = NetworkManagerMock()
            coderServiceMock = CoderServiceMock()
            sessionAdapterMock = SessionAdapterMock()
            signInAPI = SignInAPI(networkManager: networkManagerMock,
                                  coderService: coderServiceMock,
                                  sessionAdapter: sessionAdapterMock)
        }

        describe("create token") {
            context("network manager executes request -> error") {
                it("returns error") {
                    networkManagerMock.settings.shouldReturnError = true

                    signInAPI.createToken { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(networkManagerMock.calls.execute) == true
                    }
                }
            }

            context("network manager executes request -> json") {
                beforeEach {
                    coderServiceMock.settings.response = CreateValidateTokenResponse(requestToken: "requestToken")
                }

                context("json is invalid") {
                    it("returns error") {
                        coderServiceMock.settings.shouldReturnError = true

                        signInAPI.createToken { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                        }
                    }
                }

                context("json is valid") {
                    it("returns token") {
                        signInAPI.createToken { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                        }
                    }
                }
            }
        }

        describe("validate") {
            let requestToken = "requestToken"
            let username = "username"
            let password = "password"

            context("coder encodes body -> error") {
                it("returns error") {
                    coderServiceMock.settings.shouldReturnError = true

                    signInAPI.validate(requestToken: requestToken, username: username, password: password) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(coderServiceMock.calls.encode) == true
                    }
                }
            }

            context("coder encodes body -> parameters") {
                context("network manager executes request -> error") {
                    it("returns error") {
                        networkManagerMock.settings.shouldReturnError = true

                        signInAPI.validate(requestToken: requestToken,
                                           username: username,
                                           password: password) { result in

                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(coderServiceMock.calls.encode) == true
                            expect(networkManagerMock.calls.execute) == true
                        }
                    }
                }

                context("network manager executes request -> json") {
                    beforeEach {
                        coderServiceMock.settings.response = CreateValidateTokenResponse(requestToken: "requestToken")
                    }

                    context("json is invalid") {
                        it("returns error") {
                            coderServiceMock.settings.shouldReturnError = true
                            coderServiceMock.settings.errorIndex = 1

                            signInAPI.validate(requestToken: requestToken,
                                               username: username,
                                               password: password) { result in

                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(coderServiceMock.calls.encode) == true
                                expect(networkManagerMock.calls.execute) == true
                                expect(coderServiceMock.calls.decode) == true
                            }
                        }
                    }

                    context("json is valid") {
                        it("returns token") {
                            signInAPI.validate(requestToken: requestToken,
                                               username: username,
                                               password: password) { result in

                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(coderServiceMock.calls.encode) == true
                                expect(networkManagerMock.calls.execute) == true
                                expect(coderServiceMock.calls.decode) == true
                            }
                        }
                    }
                }
            }
        }

        describe("create session") {
            let requestToken = "requestToken"

            context("coder encodes body -> error") {
                it("returns error") {
                    coderServiceMock.settings.shouldReturnError = true

                    signInAPI.createSession(with: requestToken) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(coderServiceMock.calls.encode) == true
                    }
                }
            }

            context("coder encodes body -> parameters") {
                context("network manager executes request -> error") {
                    it("returns error") {
                        networkManagerMock.settings.shouldReturnError = true

                        signInAPI.createSession(with: requestToken) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(coderServiceMock.calls.encode) == true
                            expect(networkManagerMock.calls.execute) == true
                        }
                    }
                }

                context("network manager executes request -> json") {
                    beforeEach {
                        coderServiceMock.settings.response = CreateSessionResponse(sessionId: "sessionId")
                    }

                    context("json is invalid") {
                        it("returns error") {
                            coderServiceMock.settings.shouldReturnError = true
                            coderServiceMock.settings.errorIndex = 1

                            signInAPI.createSession(with: requestToken) { result in
                                guard case .failure = result else {
                                    fail()
                                    return
                                }

                                expect(coderServiceMock.calls.encode) == true
                                expect(networkManagerMock.calls.execute) == true
                                expect(coderServiceMock.calls.decode) == true
                            }
                        }
                    }

                    context("json is valid") {
                        it("returns session") {
                            signInAPI.createSession(with: requestToken) { result in
                                guard case .success = result else {
                                    fail()
                                    return
                                }

                                expect(coderServiceMock.calls.encode) == true
                                expect(networkManagerMock.calls.execute) == true
                                expect(coderServiceMock.calls.decode) == true
                                expect(sessionAdapterMock.calls.toEntity) == true
                            }
                        }
                    }
                }
            }
        }
    }
}
