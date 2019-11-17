//
//  Movie.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public struct Movie: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let overview: String
    public let posterSource: String
    public let backdropSource: String
    public let runtime: Int?
    public let releaseDate: Date?
    public let userScore: Int
    public let genres: [Genre]
    public let isFavourite: Bool

    public init(id: String,
                title: String,
                overview: String,
                posterSource: String,
                backdropSource: String,
                runtime: Int? = nil,
                releaseDate: Date? = nil,
                userScore: Int,
                genres: [Genre] = [],
                isFavourite: Bool) {

        self.id = id
        self.title = title
        self.overview = overview
        self.posterSource = posterSource
        self.backdropSource = backdropSource
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.userScore = userScore
        self.genres = genres
        self.isFavourite = isFavourite
    }

    // MARK: - Equatable

    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.overview == rhs.overview
            && lhs.posterSource == rhs.posterSource
            && lhs.backdropSource == rhs.backdropSource
            && lhs.runtime == rhs.runtime
            && lhs.releaseDate == rhs.releaseDate
            && lhs.genres == rhs.genres
            && lhs.isFavourite == rhs.isFavourite
    }
}
