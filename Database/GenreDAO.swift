//
//  GenreDAO.swift
//  Database
//
//  Created by Radyslav Krechet on 03.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data

protocol GenreDAOProtocol: class {
    func set(_ genres: [Genre], handler: @escaping Handler<[GenreEntity]>)
}

class GenreDAO<DatabaseManager: DatabaseManagerProtocol>: GenreDAOProtocol
    where DatabaseManager.Object == Genre, DatabaseManager.Entity == GenreEntity {

    private let databaseManager: DatabaseManager
    private let genreAdapter: GenreAdapterProtocol

    init(databaseManager: DatabaseManager, genreAdapter: GenreAdapterProtocol) {
        self.databaseManager = databaseManager
        self.genreAdapter = genreAdapter
    }

    func set(_ genres: [Genre], handler: @escaping Handler<[GenreEntity]>) {
        let adapter: (Genre, GenreEntity) -> GenreEntity = { object, entity in
            return self.genreAdapter.toStorage(object, entity)
        }

        databaseManager.set(objects: genres, adapter: adapter, handler: handler)
    }
}
