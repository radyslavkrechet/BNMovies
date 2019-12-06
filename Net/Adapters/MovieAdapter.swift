//
//  MovieAdapter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

private let dateFormat = "yyyy-MM-dd"
private let tmdbImageURL = "https://image.tmdb.org/t/p"
private enum TmdbImageSize: String {
    case w500, w780
}

protocol MovieAdapterProtocol {
    func toObjects(_ response: GetMoviesResponse) -> [Movie]
    func toObject(_ response: GetMovieResponse) -> Movie
}

struct MovieAdapter: MovieAdapterProtocol {
    private let genreAdapter: GenreAdapterProtocol

    init(genreAdapter: GenreAdapterProtocol = GenreAdapter()) {
        self.genreAdapter = genreAdapter
    }

    func toObjects(_ response: GetMoviesResponse) -> [Movie] {
        return response.results.map { toObject($0) }
    }

    func toObject(_ response: GetMovieResponse) -> Movie {
        var releaseDate: Date?
        if let responseReleaseDate = response.releaseDate {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            releaseDate = formatter.date(from: responseReleaseDate)
        }

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
                     releaseDate: releaseDate,
                     userScore: Int(response.voteAverage * 10),
                     genres: response.genres?.map { genreAdapter.toObject($0) } ?? [],
                     isFavourite: false)
    }
}
