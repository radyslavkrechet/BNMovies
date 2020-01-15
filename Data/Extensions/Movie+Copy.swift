//
//  Movie+Copy.swift
//  Data
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

extension Movie {
    func copy(isInFavourites: Bool? = nil, isInWatchlist: Bool? = nil) -> Movie {
        return Movie(id: id,
                     title: title,
                     overview: overview,
                     posterSource: posterSource,
                     backdropSource: backdropSource,
                     runtime: runtime,
                     releaseDate: releaseDate,
                     userScore: userScore,
                     genres: genres,
                     isInFavourites: isInFavourites ?? self.isInFavourites,
                     isInWatchlist: isInWatchlist ?? self.isInWatchlist)
    }
}
