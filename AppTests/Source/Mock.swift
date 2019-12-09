//
//  Mock.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

enum Mock {
    static var user: User {
        user(hasName: false)
    }

    static var movie: Movie {
        movie()
    }

    static func user(hasName: Bool) -> User {
        return User(id: "id", username: "username", name: hasName ? "name" : nil, avatarSource: "avatarSource")
    }

    static func movie(runtime: Int? = nil, hasReleaeDate: Bool = false, genres: [Genre] = []) -> Movie {
        return Movie(id: "id",
                     title: "title",
                     overview: "overview",
                     posterSource: "posterSource",
                     backdropSource: "backdropSource",
                     runtime: runtime,
                     releaseDate: hasReleaeDate ? Date() : nil,
                     userScore: 1,
                     genres: genres,
                     isFavourite: false)
    }

    static func genre(name: String) -> Genre {
        return Genre(id: UUID().uuidString, name: name)
    }
}