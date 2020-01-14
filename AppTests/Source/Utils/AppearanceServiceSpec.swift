//
//  AppearanceServiceSpec.swift
//  Movies
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick
import UIKit

@testable import Movies

class AppearanceServiceSpec: QuickSpec {
    override func spec() {
        describe("setup") {
            it("sets tint color for all views") {
                AppearanceService.setup()

                let tintColor = UIView.appearance().tintColor
                expect(tintColor) == "Green".color
            }
        }
    }
}
