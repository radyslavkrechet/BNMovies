//
//  SessionDAOSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Database

class SessionDAOSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var sessionDAO: SessionDAO<DatabaseManagerMock<Session, SessionEntity>>!
        var databaseManagerMock: DatabaseManagerMock<Session, SessionEntity>!
        var sessionAdapterMock: SessionAdapterMock!

        beforeEach {
            databaseManagerMock = DatabaseManagerMock()
            databaseManagerMock.settings.object = Mock.sessionObject
            databaseManagerMock.settings.entity = Mock.sessionEntity

            sessionAdapterMock = SessionAdapterMock()
            sessionDAO = SessionDAO(databaseManager: databaseManagerMock, sessionAdapter: sessionAdapterMock)
        }

        describe("set session") {
            let session = Mock.sessionObject

            context("database manager sets session -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    sessionDAO.set(session) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObject) == true
                        expect(databaseManagerMock.arguments.object) == session
                        expect(sessionAdapterMock.calls.toStorage) == true
                    }
                }
            }

            context("database manager sets session -> session entity") {
                it("returns session") {
                    sessionDAO.set(session) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObject) == true
                        expect(databaseManagerMock.arguments.object) == session
                        expect(sessionAdapterMock.calls.toStorage) == true
                    }
                }
            }
        }

        describe("get session") {
            context("database manager gets session -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    sessionDAO.getSession { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                    }
                }
            }

            context("database manager gets session -> nil") {
                it("returns nil") {
                    databaseManagerMock.settings.shouldReturnNil = true

                    sessionDAO.getSession { result in
                        guard case .success(let session) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                        expect(session).to(beNil())
                    }
                }
            }

            context("database manager gets session -> session") {
                it("returns session") {
                    sessionDAO.getSession { result in
                        guard case .success(let session) = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.getFirst) == true
                        expect(sessionAdapterMock.calls.fromStorage) == true
                        expect(session).toNot(beNil())
                    }
                }
            }
        }

        describe("delete session") {
            context("database manager deletes session -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    sessionDAO.deleteSession { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.deleteAll) == true
                    }
                }
            }

            context("database manager deletes session -> deleted entities count") {
                it("returns void") {
                    sessionDAO.deleteSession { result in
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
