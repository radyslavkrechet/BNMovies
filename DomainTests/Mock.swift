//
//  Mock.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 05.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
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
        Movie(id: "id",
              title: "title",
              overview: "overview",
              posterSource: "posterSource",
              backdropSource: "backdropSource",
              userScore: 0,
              isInFavourites: false,
              isInWatchlist: false)
    }
}
