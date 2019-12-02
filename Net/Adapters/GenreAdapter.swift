//
//  GenreAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol GenreAdapterProtocol {
    func toEntity(_ response: GenreResponse) -> Genre
}

struct GenreAdapter: GenreAdapterProtocol {
    func toEntity(_ response: GenreResponse) -> Genre {
        return Genre(id: String(response.id), name: response.name)
    }
}
