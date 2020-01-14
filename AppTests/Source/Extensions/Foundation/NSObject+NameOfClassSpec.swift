//
//  NSObject+NameOfClassSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Movies

class NSObjectNameOfClassSpec: QuickSpec {
    override func spec() {
        describe("object's name of class") {
            it("returns name of class") {
                expect(NSObject.nameOfClass) == "NSObject"
            }
        }

        describe("instance's name of class") {
            it("returns name of class") {
                let instance = NSObject()
                expect(instance.nameOfClass) == "NSObject"
            }
        }
    }
}
