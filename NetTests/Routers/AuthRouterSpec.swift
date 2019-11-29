//
//  AuthRouterSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class AuthRouterSpec: QuickSpec {
    override func spec() {
        describe("as url request") {
            let baseURL = "http://api.com"
            let apiKey = "apiKey"
            AuthRouter.serverSettings = ServerSettings(baseURL: baseURL, apiKey: apiKey)

            context("case is create token") {
                it("returns url request") {
                    let request = AuthRouter.createToken
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) == "\(baseURL)/authentication/token/new?api_key=\(apiKey)"
                    expect(urlRequest!.httpMethod) == "GET"
                }
            }

            context("case is validate token") {
                it("returns url request") {
                    let parameters = ["key": "value"]
                    let data = try? JSONSerialization.data(withJSONObject: parameters)
                    let request = AuthRouter.validateToken(parameters: parameters)
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) ==
                        "\(baseURL)/authentication/token/validate_with_login?api_key=\(apiKey)"

                    expect(urlRequest!.httpMethod) == "POST"
                    expect(urlRequest!.httpBody) == data
                }
            }

            context("case is create session") {
                it("returns url request") {
                    let parameters = ["key": "value"]
                    let data = try? JSONSerialization.data(withJSONObject: parameters)
                    let request = AuthRouter.createSession(parameters: parameters)
                    let urlRequest = try? request.asURLRequest()

                    expect(urlRequest!.url!.absoluteString) ==
                        "\(baseURL)/authentication/session/new?api_key=\(apiKey)"

                    expect(urlRequest!.httpMethod) == "POST"
                    expect(urlRequest!.httpBody) == data
                }
            }
        }
    }
}
