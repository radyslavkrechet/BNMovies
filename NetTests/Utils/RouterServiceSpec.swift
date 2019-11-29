//
//  RouterServiceSpec.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Net

class RouterServiceSpec: QuickSpec {
    override func spec() {
        describe("setup") {
            it("sets up routers") {
                let serverSettings = ServerSettings(baseURL: "baseURL", apiKey: "apiKey")
                RouterService.setup(with: serverSettings)

                expect(AuthRouter.serverSettings.baseURL) == serverSettings.baseURL
                expect(AuthRouter.serverSettings.apiKey) == serverSettings.apiKey
                expect(UserRouter.serverSettings.baseURL) == serverSettings.baseURL
                expect(UserRouter.serverSettings.apiKey) == serverSettings.apiKey
                expect(MovieRouter.serverSettings.baseURL) == serverSettings.baseURL
                expect(MovieRouter.serverSettings.apiKey) == serverSettings.apiKey
            }
        }
    }
}
