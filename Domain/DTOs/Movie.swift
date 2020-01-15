//
//  Movie.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public struct Movie: Identifiable, Equatable {
    public enum Chart: Int, Equatable {
        case popular, topRated
    }
    public enum Collection: Int, Equatable, CaseIterable {
        case favourites, watchlist
    }

    public let id: String
    public let title: String
    public let overview: String
    public let posterSource: String
    public let backdropSource: String
    public let runtime: Int?
    public let releaseDate: Date?
    public let userScore: Int
    public let genres: [Genre]
    public let isInFavourites: Bool
    public let isInWatchlist: Bool

    public init(id: String,
                title: String,
                overview: String,
                posterSource: String,
                backdropSource: String,
                runtime: Int? = nil,
                releaseDate: Date? = nil,
                userScore: Int,
                genres: [Genre] = [],
                isInFavourites: Bool,
                isInWatchlist: Bool) {

        self.id = id
        self.title = title
        self.overview = overview
        self.posterSource = posterSource
        self.backdropSource = backdropSource
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.userScore = userScore
        self.genres = genres
        self.isInFavourites = isInFavourites
        self.isInWatchlist = isInWatchlist
    }
}
