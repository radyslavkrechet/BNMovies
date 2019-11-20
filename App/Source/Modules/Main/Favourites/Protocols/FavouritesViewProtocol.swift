//
//  FavouritesViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 19.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol FavouritesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}
