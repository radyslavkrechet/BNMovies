//
//  GenreAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

protocol GenreAdapterProtocol {
    func fromStorage(_ entity: GenreEntity) -> Genre
    func toStorage(_ object: Genre, _ entity: GenreEntity) -> GenreEntity
}

struct GenreAdapter: GenreAdapterProtocol {
    func fromStorage(_ entity: GenreEntity) -> Genre {
        return Genre(id: entity.id.value, name: entity.name.value)
    }

    func toStorage(_ object: Genre, _ entity: GenreEntity) -> GenreEntity {
        entity.id.value = object.id
        entity.name.value = object.name
        return entity
    }
}
