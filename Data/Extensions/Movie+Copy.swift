//
//  Movie+Copy.swift
//  Data
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

extension Movie {
    func copy(isFavourite: Bool? = nil, isInWatchlist: Bool? = nil) -> Movie {
        return Movie(id: id,
                     title: title,
                     overview: overview,
                     posterSource: posterSource,
                     backdropSource: backdropSource,
                     runtime: runtime,
                     releaseDate: releaseDate,
                     userScore: userScore,
                     genres: genres,
                     isFavourite: isFavourite ?? self.isFavourite,
                     isInWatchlist: isInWatchlist ?? self.isInWatchlist)
    }
}
