//
//  MoviesDataSourceProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 19.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol MoviesDataSourceProtocol: PaginationTableDataSourceProtocol where Item == Movie {}
