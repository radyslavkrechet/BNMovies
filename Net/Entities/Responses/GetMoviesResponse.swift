//
//  GetMoviesResponse.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

struct GetMoviesResponse: Decodable {
    let results: [GetMovieResponse]
}
