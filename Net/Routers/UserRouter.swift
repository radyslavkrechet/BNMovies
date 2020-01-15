//
//  UserRouter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Alamofire

enum UserRouter: URLRequestConvertible {
    case getUser(token: String)

    static var serverSettings: ServerSettings!

    private var method: HTTPMethod {
        return .get
    }
    private var path: String {
        return "/account"
    }
    private var urlParameters: Parameters {
        var parameters = ["api_key": UserRouter.serverSettings.apiKey]
        if case .getUser(let token) = self {
            parameters["session_id"] = token
        }
        return parameters
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try UserRouter.serverSettings.baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParameters)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
