//
//  String+LocalizationSpec.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Boilerplate

class StringLocalizationSpec: QuickSpec {
    override func spec() {
        describe("localized") {
            it("returns localized string") {
                let localizedString = "FavouritesViewController.emptyStateText".localized
                expect(localizedString) == "There are no favourite movies"
            }
        }
    }
}
