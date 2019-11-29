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
        describe("to entity") {
            it("returns user") {
                let gravatar = GravatarResponse(hash: "hash")
                let avatar = AvatarResponse(gravatar: gravatar)
                let response = GetUserResponse(id: 0, username: "username", name: "name", avatar: avatar)
                let user = UserAdapter.toEntity(response)

                expect(user.id) == String(response.id)
                expect(user.username) == response.username
                expect(user.name) == response.name
                expect(user.avatarSource) == "https://www.gravatar.com/avatar/\(response.avatar.gravatar.hash)"
            }
        }
    }
}
