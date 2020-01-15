//
//  GetChartUseCase.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol GetChartUseCaseProtocol {
    func execute(with chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>)
}

public class GetChartUseCase: GetChartUseCaseProtocol, Executable {
    lazy var work = { [weak self] in
        guard let self = self else { return }
        self.movieRepository.getChart(self.chart, page: self.page, handler: self.handler)
    }

    @AsyncOnMain var handler: Handler<[Movie]>!

    private let movieRepository: MovieRepositoryProtocol
    private var chart: Movie.Chart!
    private var page: Int!

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }

    public func execute(with chart: Movie.Chart, page: Int, handler: @escaping Handler<[Movie]>) {
        self.chart = chart
        self.page = page
        self.handler = handler
        execute()
    }
}
