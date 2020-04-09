//
//  Test.swift
//  MoviesTests
//
//  Created by Radyslav Krechet on 09.04.2020.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class TestSpec: QuickSpec {
    override func spec() {
        it("test") {
            let value = true
            expect(value) == true
        }
    }
}
