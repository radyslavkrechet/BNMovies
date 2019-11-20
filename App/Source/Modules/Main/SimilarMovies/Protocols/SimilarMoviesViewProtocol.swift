//
//  SimilarMoviesViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SimilarMoviesViewProtocol: ListViewProtocol {
    func populate(with movies: [Movie])
}
