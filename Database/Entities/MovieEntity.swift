//
//  MovieEntity.swift
//  Database
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import CoreStore

class MovieEntity: CoreStoreObject {
    let id = Value.Required<String>("id", initial: "")
    let title = Value.Required<String>("title", initial: "")
    let overview = Value.Required<String>("overview", initial: "")
    let posterSource = Value.Required<String>("posterSource", initial: "")
    let backdropSource = Value.Required<String>("backdropSource", initial: "")
    let runtime = Value.Optional<Int>("runtime")
    let releaseDate = Value.Optional<Date>("releaseDate")
    let userScore = Value.Required<Int>("userScore", initial: 0)
    let genres = Relationship.ToManyOrdered<GenreEntity>("genres")
    let isFavourite = Value.Required<Bool>("isFavourite", initial: false)
    let isInWatchlist = Value.Required<Bool>("isInWatchlist", initial: false)
}
