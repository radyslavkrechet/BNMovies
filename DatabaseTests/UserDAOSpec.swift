//
//  UserDAOSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Database

class UserDAOSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var userDAO: UserDAO<DatabaseManagerMock<User, UserEntity>>!
        var databaseManagerMock: DatabaseManagerMock<User, UserEntity>!
        var userAdapterMock: UserAdapterMock!

        beforeEach {
            databaseManagerMock = DatabaseManagerMock()
            databaseManagerMock.settings.object = Mock.userObject
            databaseManagerMock.settings.entity = Mock.userEntity

            userAdapterMock = UserAdapterMock()
            userDAO = UserDAO(databaseManager: databaseManagerMock, userAdapter: userAdapterMock)
        }

        describe("set user") {
            let user = Mock.userObject

            context("database manager sets user -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    userDAO.set(user) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObject) == true
                        expect(databaseManagerMock.arguments.object) == user
                        expect(userAdapterMock.calls.toStorage) == true
                    }
                }
            }

            context("database manager sets user -> user entity") {
                it("returns user") {
                    userDAO.set(user) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObject) == true
                        expect(databaseManagerMock.arguments.object) == user
                        expect(userAdapterMock.calls.toStorage) == true
                    }
                }
            }
        }

        describe("get user") {
            context("database manager gets user -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    userDAO.getUser { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                    }
                }
            }

            context("database manager user movie -> nil") {
                it("returns nil") {
                    databaseManagerMock.settings.shouldReturnNil = true

                    userDAO.getUser { result in
                        guard case .success(let user) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                        expect(user).to(beNil())
                    }
                }
            }

            context("database manager gets user -> user") {
                it("returns user") {
                    userDAO.getUser { result in
                        guard case .success(let user) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                        expect(userAdapterMock.calls.fromStorage) == true
                        expect(user).toNot(beNil())
                    }
                }
            }
        }

        describe("delete user") {
            context("database manager deletes user -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    userDAO.deleteUser { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.deleteAll) == true
                    }
                }
            }

            context("database manager deletes user -> deleted entities count") {
                it("returns void") {
                    userDAO.deleteUser { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.deleteAll) == true
                    }
                }
            }
        }
    }
}
