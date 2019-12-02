//
//  CoderService.swift
//  Net
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Alamofire

protocol CoderServiceProtocol {
    func encode<Body: Encodable>(_ body: Body) throws -> Parameters
    func decode<Response: Decodable>(_ json: Any) throws -> Response
}

struct CoderService: CoderServiceProtocol {
    func encode<Body: Encodable>(_ body: Body) throws -> Parameters {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        do {
            let data = try encoder.encode(body)
            return try JSONSerialization.jsonObject(with: data) as? Parameters ?? Parameters()
        } catch {
            throw error
        }
    }

    func decode<Response: Decodable>(_ json: Any) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw error
        }
    }
}
