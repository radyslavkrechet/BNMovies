//
//  SessionAdapterSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 03.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain
import CoreStore

@testable import Database

class SessionAdapterSpec: QuickSpec {
    override func spec() {
        var sessionAdapter: SessionAdapter!

        beforeEach {
            DatabaseService.setup(isInMemoryStore: true)
            sessionAdapter = SessionAdapter()
        }

        describe("from storage") {
            it("returns session") {
                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> Session in
                        let entity = transaction.create(Into<SessionEntity>())
                        entity.id.value = "id"
                        entity.token.value = "token"

                        let object = sessionAdapter.fromStorage(entity)

                        expect(object.id) == entity.id.value
                        expect(object.token) == entity.token.value

                        return object
                    })
                }.toNot(throwError())
            }
        }

        describe("to storage") {
            it("returns session entity") {
                let object = Mock.sessionObject

                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> SessionEntity in
                        var entity = transaction.create(Into<SessionEntity>())
                        entity = sessionAdapter.toStorage(object, entity)

                        expect(entity.id.value) == object.id
                        expect(entity.token.value) == object.token

                        return entity
                    })
                }.toNot(throwError())
            }
        }
    }
}
