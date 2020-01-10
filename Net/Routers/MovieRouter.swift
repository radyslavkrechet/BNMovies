//
//  MovieRouter.swift
//  Net
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Alamofire

enum MovieRouter: URLRequestConvertible {
    case getMovies(category: Movie.Category, page: Int), getMovie(id: String), getSimilarMovies(id: String)

    static var serverSettings: ServerSettings!

    private var method: HTTPMethod {
        return .get
    }
    private var path: String {
        switch self {
        case .getMovie(let id): return "/movie/\(id)"
        case .getSimilarMovies(let id): return "/movie/\(id)/similar"
        case .getMovies(let category, _):
            var path = ""
            switch category {
            case .popular: path = "popular"
            case .topRated: path = "top_rated"
            }
            return "/movie/\(path)"
        }
    }
    private var urlParameters: Parameters {
        var parameters: Parameters = ["api_key": MovieRouter.serverSettings.apiKey]
        if case .getMovies(_, let page) = self {
            parameters["page"] = page
        }
        return parameters
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try MovieRouter.serverSettings.baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: urlParameters)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
