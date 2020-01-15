//
//  GetChartUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetChartUseCaseSpec: QuickSpec {
    override func spec() {
        var getChartUseCase: GetChartUseCase!
        var movieRepositoryMock: MovieRepositoryMock!

        beforeEach {
            movieRepositoryMock = MovieRepositoryMock()
            getChartUseCase = GetChartUseCase(movieRepository: movieRepositoryMock)
        }

        describe("execute") {
            let chart = Movie.Chart.popular
            let page = 0

            context("movie repository gets chart -> error") {
                it("returns error") {
                    movieRepositoryMock.settings.shouldReturnError = true

                    waitUntil { done in
                        getChartUseCase.execute(with: chart, page: page) { result in
                            guard case .failure = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getChart) == true
                            expect(movieRepositoryMock.arguments.chart) == chart
                            expect(movieRepositoryMock.arguments.page) == page
                            done()
                        }
                    }
                }
            }

            context("movie repository gets chart -> movies") {
                it("returns movies") {
                    waitUntil { done in
                        getChartUseCase.execute(with: chart, page: page) { result in
                            guard case .success = result else {
                                fail()
                                return
                            }

                            expect(movieRepositoryMock.calls.getChart) == true
                            expect(movieRepositoryMock.arguments.chart) == chart
                            expect(movieRepositoryMock.arguments.page) == page
                            done()
                        }
                    }
                }
            }
        }
    }
}
