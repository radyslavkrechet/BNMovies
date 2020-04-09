//
//  Movie+Displaying.swift
//  Domain
//
//  Created by Radyslav Krechet on 09.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

private let noValue = "-"

public extension Movie {
    var genresToDisplay: String {
        return genres.isEmpty ? noValue : genres.map { $0.name }.joined(separator: ", ")
    }
    var runtimeToDisplay: String {
        guard let runtime = runtime else {
            return noValue
        }

        var components = DateComponents()
        components.minute = runtime

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: components) ?? noValue
    }
    var releaseDateToDisplay: String {
        guard let releaseDate = releaseDate else {
            return noValue
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: releaseDate)
    }
}
