//
//  SessionDAO.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import Data
import CoreStore

class SessionDAO: SessionDAOProtocol {
    func set(_ session: Session, handler: @escaping Handler<Session>) {
        CoreStore.perform(asynchronous: { transaction in
            let from = From<SessionEntity>()
            let into = Into<SessionEntity>()
            let entity = try transaction.fetchOne(from) ?? transaction.create(into)
            SessionAdapter.toStorage(session, entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(session))
            }
        })
    }

    func getSession(handler: @escaping Handler<Session?>) {
        CoreStore.perform(asynchronous: { transaction -> Session? in
            let from = From<SessionEntity>()
            let entity = try transaction.fetchOne(from)

            var session: Session?
            if let entity = entity {
                session = SessionAdapter.fromStorage(entity)
            }
            return session
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let session): handler(.success(session))
            }
        })
    }

    func deleteSession(handler: @escaping Handler<Void>) {
        CoreStore.perform(asynchronous: { transaction in
            let from = From<SessionEntity>()
            try transaction.deleteAll(from)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(()))
            }
        })
    }
}
