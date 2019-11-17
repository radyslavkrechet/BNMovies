//
//  GetMovieResponse.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

struct GetMovieResponse: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let releaseDate: String
    let voteAverage: Float
    let genres: [GenreResponse]?
}

struct GenreResponse: Decodable {
    let id: Int
    let name: String
}
