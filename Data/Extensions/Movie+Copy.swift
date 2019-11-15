//
//  Movie+Copy.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/5/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

extension Movie {
    func copy(isFavourite: Bool? = nil) -> Movie {
        return Movie(id: id,
                     title: title,
                     overview: overview,
                     posterSource: posterSource,
                     backdropSource: backdropSource,
                     runtime: runtime,
                     releaseDate: releaseDate,
                     userScore: userScore,
                     genres: genres,
                     isFavourite: isFavourite ?? self.isFavourite)
    }
}
