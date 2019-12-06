//
//  Mock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 05.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

@testable import Net

enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var token: String {
        "token"
    }

    static var session: Session {
        Session(id: "id", token: token)
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
              isFavourite: false)
    }

    static var genre: Genre {
        Genre(id: "id", name: "name")
    }

    static var createSessionResponse: CreateSessionResponse {
        CreateSessionResponse(sessionId: "id")
    }

    static var getUserResponse: GetUserResponse {
        let gravatar = GravatarResponse(hash: "hash")
        let avatar = AvatarResponse(gravatar: gravatar)
        return GetUserResponse(id: 0, username: "username", name: "name", avatar: avatar)
    }

    static var getMoviesResponse: GetMoviesResponse {
        let getMovieResponse = Mock.getMovieResponse(hasOptionalValues: false)
        return GetMoviesResponse(results: [getMovieResponse])
    }

    static var genreResponse: GenreResponse {
        GenreResponse(id: 0, name: "name")
    }

    static func getMovieResponse(hasOptionalValues: Bool) -> GetMovieResponse {
        return GetMovieResponse(id: 0,
                                title: "titme",
                                overview: "overview",
                                posterPath: hasOptionalValues ? "posterPath" : nil,
                                backdropPath: hasOptionalValues ? "backdropPath" : nil,
                                runtime: hasOptionalValues ? 95 : nil,
                                releaseDate: hasOptionalValues ? "1994-09-27" : nil,
                                voteAverage: 7.5,
                                genres: hasOptionalValues ? [genreResponse] : nil)
    }
}
