//
//  MovieRouter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Alamofire

enum MovieRouter: URLRequestConvertible {
    case getMovies(page: Int), getMovie(id: String), getSimilarMovies(id: String)

    private var method: HTTPMethod {
        return .get
    }
    private var path: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        case .getMovie(let id):
            return "/movie/\(id)"
        case .getSimilarMovies(let id):
            return "/movie/\(id)/similar"
        }
    }
    private var urlParameters: Parameters {
        var parameters: Parameters = ["api_key": ServerManager.shared.apiKey]
        if case .getMovies(let page) = self {
            parameters["page"] = page
        }
        return parameters
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try ServerManager.shared.baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParameters)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
