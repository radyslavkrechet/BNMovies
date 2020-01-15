//
//  AuthRouter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Alamofire

enum AuthRouter: URLRequestConvertible {
    case createToken, validateToken(parameters: Parameters), createSession(parameters: Parameters)

    static var serverSettings: ServerSettings!

    private var method: HTTPMethod {
        switch self {
        case .createToken: return .get
        default: return .post
        }
    }
    private var path: String {
        switch self {
        case .createToken: return "/authentication/token/new"
        case .validateToken: return "/authentication/token/validate_with_login"
        case .createSession: return "/authentication/session/new"
        }
    }
    private var urlParameters: Parameters {
        return ["api_key": AuthRouter.serverSettings.apiKey]
    }
    private var jsonParameters: Parameters? {
        switch self {
        case .validateToken(let parameters), .createSession(let parameters): return parameters
        default: return nil
        }
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try AuthRouter.serverSettings.baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParameters)
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: jsonParameters)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
