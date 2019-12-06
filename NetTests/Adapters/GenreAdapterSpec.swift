//
//  GenreAdapterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Net

class GenreAdapterSpec: QuickSpec {
    override func spec() {
        describe("to object") {
            it("returns genre") {
                let response = Mock.genreResponse
                let genre = GenreAdapter().toObject(response)

                expect(genre.id) == String(response.id)
                expect(genre.name) == response.name
            }
        }
    }
}
