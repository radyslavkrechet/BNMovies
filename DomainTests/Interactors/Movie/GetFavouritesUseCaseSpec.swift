//
//  GetFavouritesUseCaseSpec.swift
//  DomainTests
//
//  Created by Radyslav Krechet on 27.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Domain

class GetFavouritesUseCaseSpec: QuickSpec {
    override func spec() {
        describe("execute") {
            context("movie repository returns error") {
                it("returns error") {
                    let movieRepository = MovieRepositoryMock(settings: .failure)
                    let getFavouritesUseCase = GetFavouritesUseCase(movieRepository: movieRepository)

                    getFavouritesUseCase.execute { result in
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
                    let getFavouritesUseCase = GetFavouritesUseCase(movieRepository: movieRepository)

                    getFavouritesUseCase.execute { result in
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
