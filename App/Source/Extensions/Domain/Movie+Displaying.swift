//
//  Movie+Displaying.swift
//  Movies
//
//  Created by Radyslav Krechet on 9/4/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import UIKit

private let noValue = "-"

extension Movie {
    var posterPlaceholder: UIImage? {
        return "Poster".image
    }
    var backdropPlaceholder: UIImage? {
        return "Backdrop".image
    }
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
