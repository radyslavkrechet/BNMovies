//
//  DetailsPresenterProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol: ContentPresenterProtocol {
    var id: String! { get set }

    func markMovieAsFavourite()
}
