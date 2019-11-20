//
//  DetailsViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol DetailsViewProtocol: ContentViewProtocol {
    func populate(with movie: Movie)
    func populate(with favouriteTitle: String)
    func presentFavouriteError(_ error: Error)
}
