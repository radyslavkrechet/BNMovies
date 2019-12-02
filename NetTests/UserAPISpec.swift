//
//  UserAPISpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class UserAPISpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var networkManagerMock: NetworkManagerMock!
        var coderServiceMock: CoderServiceMock!
        var userAdapterMock: UserAdapterMock!
        var userAPI: UserAPI!

        beforeEach {
            networkManagerMock = NetworkManagerMock()
            coderServiceMock = CoderServiceMock()
            userAdapterMock = UserAdapterMock()
            userAPI = UserAPI(networkManager: networkManagerMock,
                              coderService: coderServiceMock,
                              userAdapter: userAdapterMock)
        }

        describe("get user") {
            let token = "token"

            context("network manager executes request -> error") {
                it("returns error") {
                    networkManagerMock.settings.shouldReturnError = true

                    userAPI.getUser(with: token) { result in
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
                    let gravatar = GravatarResponse(hash: "hash")
                    let avatar = AvatarResponse(gravatar: gravatar)
                    let user = GetUserResponse(id: 0, username: "username", name: "name", avatar: avatar)
                    coderServiceMock.settings.response = user
                }

                context("json is invalid") {
                    it("returns error") {
                        coderServiceMock.settings.shouldReturnError = true

                        userAPI.getUser(with: token) { result in
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
                    it("returns user") {
                        userAPI.getUser(with: token) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(networkManagerMock.calls.execute) == true
                            expect(coderServiceMock.calls.decode) == true
                            expect(userAdapterMock.calls.toEntity) == true
                        }
                    }
                }
            }
        }
    }
}
