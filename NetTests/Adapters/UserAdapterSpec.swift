//
//  UserAdapterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import Domain

@testable import Net

class UserAdapterSpec: QuickSpec {
    override func spec() {
        describe("to object") {
            it("returns user") {
                let response = Mock.getUserResponse
                let user = UserAdapter().toObject(response)

                expect(user.id) == String(response.id)
                expect(user.username) == response.username
                expect(user.name) == response.name
                expect(user.avatarSource) == "https://www.gravatar.com/avatar/\(response.avatar.gravatar.hash)"
            }
        }
    }
}
