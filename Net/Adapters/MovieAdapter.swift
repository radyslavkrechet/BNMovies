//
//  MovieAdapter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

private let dateFormat = "yyyy-MM-dd"
private let tmdbImageURL = "https://image.tmdb.org/t/p"
private enum TmdbImageSize: String {
    case w500, w780
}

enum MovieAdapter {
    static func toEntity(_ response: GetMoviesResponse) -> [Movie] {
        return response.results.map { toEntity($0) }
    }

    static func toEntity(_ response: GetMovieResponse) -> Movie {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat

        var posterSource = ""
        if let posterPath = response.posterPath {
            posterSource = "\(tmdbImageURL)/\(TmdbImageSize.w500.rawValue)\(posterPath)"
        }

        var backdropSource = ""
        if let backdropPath = response.backdropPath {
            backdropSource = "\(tmdbImageURL)/\(TmdbImageSize.w780.rawValue)\(backdropPath)"
        }

        return Movie(id: String(response.id),
                     title: response.title,
                     overview: response.overview,
                     posterSource: posterSource,
                     backdropSource: backdropSource,
                     runtime: response.runtime,
                     releaseDate: formatter.date(from: response.releaseDate),
                     userScore: Int(response.voteAverage * 10),
                     genres: response.genres?.map { GenreAdapter.toEntity($0) } ?? [],
                     isFavourite: false)
    }
}
