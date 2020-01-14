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
                let localizedString = "MoviesViewController.favourites.emptyStateText".localized
                expect(localizedString) == "There are no favourite movies"
            }
        }

        describe("image") {
            it("returns image from assets") {
                let imageName = "Avatar"
                let image = imageName.image
                expect(image) == UIImage(named: imageName)
            }
        }

        describe("image") {
            it("returns image from assets") {
                let systemImageName = "heart"
                let image = systemImageName.systemImage
                expect(image) == UIImage(systemName: systemImageName)
            }
        }

        describe("color") {
            it("returns color from assets") {
                let colorName = "Green"
                let color = colorName.color
                expect(color) == UIColor(named: colorName)
            }
        }
    }
}
