//
//  SessionAdapterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Net

class SessionAdapterSpec: QuickSpec {
    override func spec() {
        describe("to object") {
            it("returns session") {
                let response = Mock.createSessionResponse
                let session = SessionAdapter().toObject(response)

                expect(session.id) == response.sessionId
                expect(session.token) == response.sessionId
            }
        }
    }
}
