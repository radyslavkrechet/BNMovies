//
//  SimilarMoviesDataSourceProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SimilarMoviesDataSourceProtocol: ListCollectionDataSourceProtocol where Item == Movie {}
