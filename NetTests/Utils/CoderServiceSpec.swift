//
//  CoderServiceSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class CoderServiceSpec: QuickSpec {
    override func spec() {
        describe("encode") {
            context("encode is valid") {
                it("returns parameters") {
                    let body = Container(storedValue: 2.3)

                    expect {
                        let parameters = try CoderService.encode(body) as? [String: Double]
                        return parameters
                    } == ["stored_value": 2.3]
                }
            }

            context("encode is valid") {
                it("throws error") {
                    let body = Container(storedValue: Double.infinity)

                    expect {
                        let parameters = try CoderService.encode(body)
                        return parameters
                    }.to(throwError())
                }
            }
        }

        describe("decode") {
            context("decode is valid") {
                it("returns response") {
                    let json = ["stored_value": 2.3]

                    expect {
                        let response: Container = try CoderService.decode(json)
                        return response.storedValue
                    } == json["stored_value"]
                }
            }

            context("decode is invalid") {
                it("throws error") {
                    let json = ["key": "value"]

                    expect {
                        let response: Container = try CoderService.decode(json)
                        return response
                    }.to(throwError())
                }
            }
        }
    }
}

private struct Container: Codable {
    var storedValue: Double
}
