//
//  GetMoviesUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetMoviesUseCaseSpec: QuickSpec {
    private let page = 0

    override func spec() {
        describe("execute") {
            context("movie repository returns error") {
                it("returns error") {
                    let movieRepository = MovieRepositoryMock(settings: .failure)
                    let getMoviesUseCase = GetMoviesUseCase(movieRepository: movieRepository)

                    getMoviesUseCase.execute(with: self.page) { result in
                        switch result {
                        case .failure: pass()
                        case .success: fail()
                        }
                    }
                }
            }

            context("movie repository returns movies") {
                it("returns movies") {
                    let movieRepository = MovieRepositoryMock(settings: .success(isTruthy: true))
                    let getMoviesUseCase = GetMoviesUseCase(movieRepository: movieRepository)

                    getMoviesUseCase.execute(with: self.page) { result in
                        switch result {
                        case .failure: fail()
                        case .success: pass()
                        }
                    }
                }
            }
        }
    }
}
