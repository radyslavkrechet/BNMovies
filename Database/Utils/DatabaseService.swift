//
//  DatabaseService.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import CoreStore

enum DatabaseService {
    static func setup() {
        let entities: [DynamicEntity] = [
            Entity<SessionEntity>("SessionEntity"),
            Entity<UserEntity>("UserEntity"),
            Entity<MovieEntity>("MovieEntity"),
            Entity<GenreEntity>("GenreEntity")
        ]

        let schema = CoreStoreSchema(modelVersion: "V1", entities: entities)
        CoreStore.defaultStack = DataStack(schema)

        do {
            try CoreStore.addStorageAndWait()
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
}
