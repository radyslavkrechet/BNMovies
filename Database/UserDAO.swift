//
//  UserDAO.swift
//  Database
//
//  Created by Radyslav Krechet on 8/27/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import Data
import CoreStore

class UserDAO: UserDAOProtocol {
    func set(_ user: User, handler: @escaping Handler<User>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction in
            let from = From<UserEntity>()
            let into = Into<UserEntity>()
            let entity = try transaction.fetchOne(from) ?? transaction.create(into)
            UserAdapter.toStorage(user, entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(user))
            }
        })
    }

    func getUser(handler: @escaping Handler<User?>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> User? in
            let from = From<UserEntity>()
            let entity = try transaction.fetchOne(from)

            var user: User?
            if let entity = entity {
                user = UserAdapter.fromStorage(entity)
            }
            return user
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let user): handler(.success(user))
            }
        })
    }

    func deleteUser(handler: @escaping Handler<Void>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction in
            let from = From<UserEntity>()
            try transaction.deleteAll(from)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success: handler(.success(()))
            }
        })
    }
}
