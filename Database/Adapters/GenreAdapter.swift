//
//  GenreAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

enum GenreAdapter {
    static func fromStorage(_ entity: GenreEntity) -> Genre {
        return Genre(id: entity.id.value, name: entity.name.value)
    }

    static func toStorage(_ genre: Genre, _ entity: GenreEntity) {
        entity.id.value = genre.id
        entity.name.value = genre.name
    }
}
