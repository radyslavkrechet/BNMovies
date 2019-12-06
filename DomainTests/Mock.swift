//
//  Mock.swift
//  DomainTests
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
        movie(isFavourite: false)
    }

    static func movie(isFavourite: Bool) -> Movie {
        return Movie(id: "id",
                     title: "title",
                     overview: "overview",
                     posterSource: "posterSource",
                     backdropSource: "backdropSource",
                     userScore: 0,
                     isFavourite: isFavourite)
    }
}
