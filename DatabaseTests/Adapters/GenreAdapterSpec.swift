//
//  GenreAdapterSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain
import CoreStore

@testable import Database

class GenreAdapterSpec: QuickSpec {
    override func spec() {
        var genreAdapter: GenreAdapter!

        beforeEach {
            DatabaseService.setup(isInMemoryStore: true)
            genreAdapter = GenreAdapter()
        }

        describe("from storage") {
            it("returns genre") {
                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> Genre in
                        let entity = transaction.create(Into<GenreEntity>())
                        entity.id.value = "id"
                        entity.name.value = "name"

                        let object = genreAdapter.fromStorage(entity)

                        expect(object.id) == entity.id.value
                        expect(object.name) == entity.name.value

                        return object
                    })
                }.toNot(throwError())
            }
        }

        describe("to storage") {
            it("returns genre entity") {
                let object = Mock.genreObject

                expect {
                    return try CoreStoreDefaults.dataStack.perform(synchronous: { transaction -> GenreEntity in
                        var entity = transaction.create(Into<GenreEntity>())
                        entity = genreAdapter.toStorage(object, entity)

                        expect(entity.id.value) == object.id
                        expect(entity.name.value) == object.name

                        return entity
                    })
                }.toNot(throwError())
            }
        }
    }
}
