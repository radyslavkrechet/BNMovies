//
//  MovieRouterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class MovieRouterSpec: QuickSpec {
    override func spec() {
        let baseURL = "http://api.com"
        let apiKey = "apiKey"

        beforeEach {
            MovieRouter.serverSettings = ServerSettings(baseURL: baseURL, apiKey: apiKey)
        }

        describe("as url request") {
            context("case is get movies") {
                context("category is popular") {
                    it("returns url request") {
                        let page = 0
                        let request = MovieRouter.getMovies(category: .popular, page: page)
                        let urlRequest = try? request.asURLRequest()

                        expect(urlRequest!.url!.absoluteString) ==
                            "\(baseURL)/movie/popular?api_key=\(apiKey)&page=\(page)"

                        expect(urlRequest!.httpMethod) == "GET"
                    }
                }

                context("category is top rated") {
                    it("returns url request") {
                        let page = 0
                        let request = MovieRouter.getMovies(category: .topRated, page: page)
                        let urlRequest = try? request.asURLRequest()

                        expect(urlRequest!.url!.absoluteString) ==
                            "\(baseURL)/movie/top_rated?api_key=\(apiKey)&page=\(page)"

                        expect(urlRequest!.httpMethod) == "GET"
                    }
                }
            }

            context("case is get movie") {
                it("returns url request") {
                    let id = "id"
                    let request = MovieRouter.getMovie(id: id)
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) == "\(baseURL)/movie/\(id)?api_key=\(apiKey)"
                    expect(urlRequest!.httpMethod) == "GET"
                }
            }

            context("case is get similar movies") {
                it("returns url request") {
                    let id = "id"
                    let request = MovieRouter.getSimilarMovies(id: id)
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) == "\(baseURL)/movie/\(id)/similar?api_key=\(apiKey)"
                    expect(urlRequest!.httpMethod) == "GET"
                }
            }
        }
    }
}
