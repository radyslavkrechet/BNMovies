//
//  Mock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 05.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Database

enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var sessionObject: Session {
        Session(id: "id", token: "token")
    }

    static var userObject: User {
        User(id: "id", username: "username", avatarSource: "avatarSource")
    }

    static var movieObject: Movie {
        Movie(id: "id",
              title: "title",
              overview: "overview",
              posterSource: "posterSource",
              backdropSource: "backdropSource",
              userScore: 0,
              isFavourite: false)
    }

    static var genreObject: Genre {
        Genre(id: "id", name: "name")
    }

    static var sessionEntity: SessionEntity {
        SessionEntity(asMeta: ())
    }

    static var userEntity: UserEntity {
        UserEntity(asMeta: ())
    }

    static var movieEntity: MovieEntity {
        MovieEntity(asMeta: ())
    }

    static var genreEntity: GenreEntity {
        GenreEntity(asMeta: ())
    }
}
