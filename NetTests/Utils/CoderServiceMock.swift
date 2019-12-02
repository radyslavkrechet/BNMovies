//
//  CoderServiceMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation
import Alamofire

@testable import Net

private enum Mock {
    enum Error: Swift.Error {
        case force
    }
}

class CoderServiceMock: CoderServiceProtocol {
    struct Settings {
        var shouldReturnError = false
        var errorIndex = 0
        var response: Decodable!
    }

    struct Calls {
        var encode = false
        var decode = false
    }

    var settings = Settings()
    var calls = Calls()

    private var runIndex = -1
    private var shouldReturnError: Bool { settings.shouldReturnError && settings.errorIndex == runIndex }

    func encode<Body: Encodable>(_ body: Body) throws -> Parameters {
        run()
        calls.encode = true
        if shouldReturnError {
            throw Mock.Error.force
        } else {
            return [:]
        }
    }

    func decode<Response: Decodable>(_ json: Any) throws -> Response {
        run()
        calls.decode = true
        if shouldReturnError {
            throw Mock.Error.force
        } else {
             // swiftlint:disable:next force_cast
            return settings.response as! Response
        }
    }

    private func run() {
        runIndex += 1
    }
}
