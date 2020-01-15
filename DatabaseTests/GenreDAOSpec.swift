//
//  GenreDAOSpec.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Database

class GenreDAOSpec: QuickSpec {
    override func spec() {
        var genreDAO: GenreDAO<DatabaseManagerMock<Genre, GenreEntity>>!
        var databaseManagerMock: DatabaseManagerMock<Genre, GenreEntity>!
        var genreAdapterMock: GenreAdapterMock!

        beforeEach {
            databaseManagerMock = DatabaseManagerMock()
            genreAdapterMock = GenreAdapterMock()
            genreDAO = GenreDAO(databaseManager: databaseManagerMock, genreAdapter: genreAdapterMock)
        }

        describe("set genres") {
            let genres = [Mock.genreObject]

            beforeEach {
                databaseManagerMock.settings.object = Mock.genreObject
                databaseManagerMock.settings.entity = Mock.genreEntity
            }

            context("database manager sets genres -> error") {
                it("returns error") {
                    databaseManagerMock.settings.shouldReturnError = true

                    genreDAO.set(genres) { result in
                        guard case .failure = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObjects) == true
                        expect(databaseManagerMock.arguments.objects) == genres
                        expect(genreAdapterMock.calls.toStorage) == true
                    }
                }
            }

            context("database manager sets genres -> genre entities") {
                it("returns genre entities") {
                    genreDAO.set(genres) { result in
                        guard case .success = result else {
                            fail()
                            return
                        }

                        expect(databaseManagerMock.calls.setObjects) == true
                        expect(databaseManagerMock.arguments.objects) == genres
                        expect(genreAdapterMock.calls.toStorage) == true
                    }
                }
            }
        }
    }
}
