//
//  UserDAO.swift
//  Database
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import Data

class UserDAO<DatabaseManager: DatabaseManagerProtocol>: UserDAOProtocol
    where DatabaseManager.Object == User, DatabaseManager.Entity == UserEntity {

    private let databaseManager: DatabaseManager
    private let userAdapter: UserAdapterProtocol

    init(databaseManager: DatabaseManager, userAdapter: UserAdapterProtocol) {
        self.databaseManager = databaseManager
        self.userAdapter = userAdapter
    }

    func set(_ user: User, handler: @escaping Handler<User>) {
        let adapter: (User, UserEntity) -> UserEntity = { object, entity in
            return self.userAdapter.toStorage(object, entity)
        }

        databaseManager.set(object: user, adapter: adapter) { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success((user)))
            }
        }
    }

    func getUser(handler: @escaping Handler<User?>) {
        let adapter: (UserEntity) -> User = { entity in
            return self.userAdapter.fromStorage(entity)
        }

        databaseManager.getFirst(adapter: adapter, handler: handler)
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        databaseManager.deleteAll { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(()))
            }
        }
    }
}
