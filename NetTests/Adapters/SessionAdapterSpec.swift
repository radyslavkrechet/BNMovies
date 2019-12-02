//
//  SessionAdapterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Net

class SessionAdapterSpec: QuickSpec {
    override func spec() {
        describe("to entity") {
            it("returns session") {
                let response = CreateSessionResponse(sessionId: "id")
                let session = SessionAdapter().toEntity(response)

                expect(session.token) == response.sessionId
            }
        }
    }
}
