//
//  GenreAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

protocol GenreAdapterProtocol {
    func toObject(_ response: GenreResponse) -> Genre
}

struct GenreAdapter: GenreAdapterProtocol {
    func toObject(_ response: GenreResponse) -> Genre {
        return Genre(id: String(response.id), name: response.name)
    }
}
