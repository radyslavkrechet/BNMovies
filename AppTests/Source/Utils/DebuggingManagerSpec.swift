//
//  DebuggingManagerSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import FLEX

@testable import Movies

class DebuggingManagerSpec: QuickSpec {
    override func spec() {
        describe("setup") {
            it("enables network debugging") {
                DebuggingManager.setup()

                let isNetworkDebuggingEnabled = FLEXManager.shared()?.isNetworkDebuggingEnabled
                expect(isNetworkDebuggingEnabled) == true
            }
        }

        describe("toggle explorer") {
            context("explorer is hidden") {
                it("shows explorer") {
                    FLEXManager.shared()?.hideExplorer()
                    DebuggingManager.toggleExplorer()

                    let isHidden = FLEXManager.shared()?.isHidden
                    expect(isHidden) == false
                }
            }

            context("explorer is not hidden") {
                it("hides explorer") {
                    FLEXManager.shared()?.showExplorer()
                    DebuggingManager.toggleExplorer()

                    let isHidden = FLEXManager.shared()?.isHidden
                    expect(isHidden) == true
                }
            }
        }
    }
}
