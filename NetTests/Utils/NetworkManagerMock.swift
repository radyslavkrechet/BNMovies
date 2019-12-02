//
//  NetworkManagerMock.swift
//  NetTests
//
//  Created by Radyslav Krechet on 29.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Alamofire

@testable import Net

private enum Mock {
    enum Error: Swift.Error {
        case force
    }

    static var successValue: [String: Any] {
        [:]
    }
}

class NetworkManagerMock: NetworkManagerProtocol {
    struct Settings {
        var shouldReturnError = false
    }

    struct Calls {
        var execute = false
    }

    var settings = Settings()
    var calls = Calls()

    func execute(_ request: URLRequestConvertible, handler: @escaping Handler<Any>) {
        calls.execute = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(Mock.successValue))
    }
}
