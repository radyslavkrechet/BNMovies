//
//  CoderService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/6/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Alamofire

enum CoderService {
    static func encode<V: Encodable>(_ body: V) throws -> Parameters {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        do {
            let data = try encoder.encode(body)
            return try JSONSerialization.jsonObject(with: data) as? Parameters ?? Parameters()
        } catch {
            throw error
        }
    }

    static func decode<V: Decodable>(_ json: Any) throws -> V {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return try decoder.decode(V.self, from: data)
        } catch {
            throw error
        }
    }
}
