//
//  Mock.swift
//  Mock
//
//  Created by Radyslav Krechet on 28.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

public enum Mock {
    public enum Error: Swift.Error {
        case force
    }

    public static var session: Session {
        Session(token: "token")
    }

    public static var user: User {
        User(id: "id", username: "username", name: "name", avatarSource: "avatarSource")
    }

    public static var movie: Movie {
        Movie(id: "id",
              title: "title",
              overview: "overview",
              posterSource: "posterSource",
              backdropSource: "backdropSource",
              runtime: 0,
              releaseDate: Date(),
              userScore: 0,
              genres: [Genre(id: "id", name: "name")],
              isFavourite: false)
    }
}
