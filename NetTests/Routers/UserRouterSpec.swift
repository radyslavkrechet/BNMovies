//
//  UserRouterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class UserRouterSpec: QuickSpec {
    override func spec() {
        describe("as url request") {
            context("case is get user") {
                it("returns url request") {
                    let baseURL = "http://api.com"
                    let apiKey = "apiKey"
                    UserRouter.serverSettings = ServerSettings(baseURL: baseURL, apiKey: apiKey)

                    let token = "token"
                    let request = UserRouter.getUser(token: token)
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) ==
                        "\(baseURL)/account?api_key=\(apiKey)&session_id=\(token)"

                    expect(urlRequest!.httpMethod) == "GET"
                }
            }
        }
    }
}
