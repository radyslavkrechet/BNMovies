//
//  User+DisplayingSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import UIKit

@testable import Movies

class UserDisplayingSpec: QuickSpec {
    override func spec() {
        describe("name to display") {
            context("user has name") {
                it("returns name") {
                    let user = Mock.user(hasName: true)
                    expect(user.nameToDisplay) == user.name
                }
            }

            context("user has not name") {
                it("returns username") {
                    let user = Mock.user(hasName: false)
                    expect(user.nameToDisplay) == user.username
                }
            }
        }

        describe("avatar placeholder") {
            it("returns avatar placeholder") {
                let user = Mock.user
                expect(user.avatarPlaceholder) == "Avatar".image
            }
        }
    }
}
