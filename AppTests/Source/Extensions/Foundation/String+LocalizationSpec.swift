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

        describe("image") {
            it("returns image from assets") {
                let avataraImageName = "Avatar"
                let image = avataraImageName.image
                expect(image) == UIImage(named: avataraImageName)
            }
        }

        describe("color") {
            it("returns color from assets") {
                let brandColorName = "Brand"
                let color = brandColorName.color
                expect(color) == UIColor(named: brandColorName)
            }
        }
    }
}
