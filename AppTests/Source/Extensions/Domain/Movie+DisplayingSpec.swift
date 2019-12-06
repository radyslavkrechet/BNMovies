//
//  Movie+DisplayingSpec.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import UIKit

@testable import Boilerplate

class MovieDisplayingSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        describe("poster placeholder") {
            it("returns poster placeholder") {
                let movie = Mock.movie
                expect(movie.posterPlaceholder) == UIImage(named: "Poster")
            }
        }

        describe("backdrop placeholder") {
            it("returns backdrop placeholder") {
                let movie = Mock.movie
                expect(movie.backdropPlaceholder) == UIImage(named: "Backdrop")
            }
        }

        describe("genres to display") {
            context("movie has not genres") {
                it("returns dash") {
                    let movie = Mock.movie
                    expect(movie.genresToDisplay) == "-"
                }
            }

            context("movie has genres") {
                it("returns separated genres names") {
                    let firstGenreName = "firstGenreName"
                    let secondGenreName = "secondGenreName"
                    let genres = [Mock.genre(name: firstGenreName), Mock.genre(name: secondGenreName)]
                    let movie = Mock.movie(genres: genres)
                    expect(movie.genresToDisplay) == "\(firstGenreName), \(secondGenreName)"
                }
            }
        }

        describe("runtime to display") {
            context("movie has not runtime") {
                it("returns dash") {
                    let movie = Mock.movie
                    expect(movie.runtimeToDisplay) == "-"
                }
            }

            context("movie has runtime") {
                context("runtime contains minutes only") {
                    it("returns formatted time") {
                        let movie = Mock.movie(runtime: 30)
                        expect(movie.runtimeToDisplay) == "30m"
                    }
                }

                context("runtime contains hours only") {
                    it("returns formatted time") {
                        let movie = Mock.movie(runtime: 60)
                        expect(movie.runtimeToDisplay) == "1h"
                    }
                }

                context("runtime contains hours and minutes") {
                    it("returns formatted time") {
                        let movie = Mock.movie(runtime: 90)
                        expect(movie.runtimeToDisplay) == "1h 30m"
                    }
                }
            }
        }

        describe("release date to display") {
            context("movie has not release date ") {
                it("returns dash") {
                    let movie = Mock.movie
                    expect(movie.releaseDateToDisplay) == "-"
                }
            }

            context("movie has not release date ") {
                it("returns formatted date") {
                    let movie = Mock.movie(hasReleaeDate: true)

                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium

                    expect(movie.releaseDateToDisplay) == formatter.string(from: movie.releaseDate!)
                }
            }
        }
    }
}
