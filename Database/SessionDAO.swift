//
//  SessionDAO.swift
//  Database
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import CoreStore

class SessionDAO<DatabaseManager: DatabaseManagerProtocol>: SessionDAOProtocol
    where DatabaseManager.Object == Session, DatabaseManager.Entity == SessionEntity {

    private let databaseManager: DatabaseManager
    private let sessionAdapter: SessionAdapterProtocol

    init(databaseManager: DatabaseManager, sessionAdapter: SessionAdapterProtocol) {
        self.databaseManager = databaseManager
        self.sessionAdapter = sessionAdapter
    }

    func set(_ session: Session, handler: @escaping Handler<Session>) {
        let adapter: (Session, SessionEntity) -> SessionEntity = { object, entity in
            return self.sessionAdapter.toStorage(object, entity)
        }

        databaseManager.set(object: session, adapter: adapter) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success((session)))
            }
        }
    }

    func getSession(handler: @escaping Handler<Session?>) {
        let adapter: (SessionEntity) -> Session = { entity in
            return self.sessionAdapter.fromStorage(entity)
        }

        databaseManager.getFirst(adapter: adapter, handler: handler)
    }

    func deleteSession(handler: @escaping Handler<Void>) {
        databaseManager.deleteAll { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(()))
            }
        }
    }
}
