//
//  GenreAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

enum GenreAdapter {
    static func toEntity(_ response: GenreResponse) -> Genre {
        return Genre(id: String(response.id), name: response.name)
    }
}
