//
//  UserAdapterSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain
import CoreStore

@testable import Database

class UserAdapterSpec: QuickSpec {
    override func spec() {
        var userAdapter: UserAdapter!

        beforeEach {
            DatabaseService.setup(isInMemoryStore: true)
            userAdapter = UserAdapter()
        }

        describe("from storage") {
            it("returns user") {
                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> User in
                        let entity = transaction.create(Into<UserEntity>())
                        entity.id.value = "id"
                        entity.username.value = "username"
                        entity.name.value = "name"
                        entity.avatarSource.value = "avatarSource"

                        let object = userAdapter.fromStorage(entity)

                        expect(object.id) == entity.id.value
                        expect(object.username) == entity.username.value
                        expect(object.name) == entity.name.value
                        expect(object.avatarSource) == entity.avatarSource.value

                        return object
                    })
                }.toNot(throwError())
            }
        }

        describe("to storage") {
            it("returns user entity") {
                let object = User(id: "id", username: "username", name: "name", avatarSource: "avatarSource")

                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> UserEntity in
                        var entity = transaction.create(Into<UserEntity>())
                        entity = userAdapter.toStorage(object, entity)

                        expect(entity.id.value) == object.id
                        expect(entity.username.value) == object.username
                        expect(entity.name.value) == object.name
                        expect(entity.avatarSource.value) == object.avatarSource

                        return entity
                    })
                }.toNot(throwError())
            }
        }
    }
}
