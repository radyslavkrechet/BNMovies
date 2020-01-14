//
//  Mock.swift
//  DataTests
//
//  Created by Radyslav Krechet on 05.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var session: Session {
        Session(id: "id", token: "token")
    }

    static var user: User {
        User(id: "id", username: "username", avatarSource: "avatarSource")
    }

    static var movie: Movie {
        movie(isFavourite: false, isInWatchlist: false)
    }

    static func movie(isFavourite: Bool, isInWatchlist: Bool) -> Movie {
        return Movie(id: "id",
                     title: "title",
                     overview: "overview",
                     posterSource: "posterSource",
                     backdropSource: "backdropSource",
                     runtime: 0,
                     releaseDate: Date(),
                     userScore: 1,
                     genres: [Genre(id: "id", name: "name")],
                     isFavourite: isFavourite,
                     isInWatchlist: isInWatchlist)
    }
}
