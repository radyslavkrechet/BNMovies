//
//  DatabaseService.swift
//  Database
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import CoreStore

enum DatabaseService {
    static func setup(isInMemoryStore: Bool = false) {
        let entities: [DynamicEntity] = [
            Entity<SessionEntity>("SessionEntity"),
            Entity<UserEntity>("UserEntity"),
            Entity<MovieEntity>("MovieEntity"),
            Entity<GenreEntity>("GenreEntity")
        ]

        let schema = CoreStoreSchema(modelVersion: "V1", entities: entities)
        CoreStoreDefaults.dataStack = DataStack(schema)

        do {
            if isInMemoryStore {
                let stotage = InMemoryStore()
                try CoreStoreDefaults.dataStack.addStorageAndWait(stotage)
            } else {
                try CoreStoreDefaults.dataStack.addStorageAndWait()
            }
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
}
