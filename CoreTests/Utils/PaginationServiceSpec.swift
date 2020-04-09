//
//  PaginationServiceSpec.swift
//  CoreTests
//
//  Created by Radyslav Krechet on 06.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Nimble
import Quick

@testable import Core

class PaginationServiceSpec: QuickSpec {
    // swiftlint:disable:next function_body_length
    override func spec() {
        var paginationService: PaginationService!

        beforeEach {
            paginationService = PaginationService()
        }

        describe("init") {
            it("has correct values") {
                expect(paginationService.page) == 1
                expect(paginationService.canGetMore) == true
                expect(paginationService.isFirstPage) == true
            }
        }

        describe("start loading") {
            it("marks as loading") {
                paginationService.startLoading()

                expect(paginationService.canGetMore) == false
            }
        }

        describe("stop loading") {
            context("not full page was loaded") {
                it("unmarks as loading") {
                    paginationService.stopLoading(with: 19)

                    expect(paginationService.page) == 2
                    expect(paginationService.canGetMore) == false
                    expect(paginationService.isFirstPage) == false
                }
            }

            context("full page was loaded") {
                it("unmarks as loading") {
                    paginationService.stopLoading(with: 20)

                    expect(paginationService.page) == 2
                    expect(paginationService.canGetMore) == true
                    expect(paginationService.isFirstPage) == false
                }
            }
        }

        describe("reset") {
            beforeEach {
                paginationService.startLoading()
            }

            context("is loading now") {
                it("resets values") {
                    paginationService.reset()

                    expect(paginationService.page) == 1
                    expect(paginationService.canGetMore) == true
                    expect(paginationService.isFirstPage) == true
                }
            }

            context("is not loading now") {
                context("not full page was loaded") {
                    it("resets values") {
                        paginationService.stopLoading(with: 19)
                        paginationService.reset()

                        expect(paginationService.page) == 1
                        expect(paginationService.canGetMore) == true
                        expect(paginationService.isFirstPage) == true
                    }
                }

                context("full page was loaded") {
                    it("resets values") {
                        paginationService.stopLoading(with: 20)
                        paginationService.reset()

                        expect(paginationService.page) == 1
                        expect(paginationService.canGetMore) == true
                        expect(paginationService.isFirstPage) == true
                    }
                }
            }
        }
    }
}
