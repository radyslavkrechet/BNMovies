//
//  DatabaseManager.swift
//  Database
//
//  Created by Radyslav Krechet on 02.12.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import CoreStore

private let equalIdsPredicateFormat = "id == %@"

protocol DatabaseManagerProtocol {
    associatedtype Object: Identifiable
    associatedtype Entity: CoreStoreObject

    func set(object: Object, adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<Entity>)
    func set(objects: [Object], adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<[Entity]>)

    func set<Relationship: CoreStoreObject>(object: Object,
                                            relationship: [Relationship],
                                            adapter: @escaping (Object, Entity, [Relationship]) -> Entity,
                                            handler: @escaping Handler<Entity>)

    func getFirst(adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>)
    func getFirst(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>)
    func getAll(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<[Object]>)
    func deleteAll(handler: @escaping Handler<Int>)
}

struct DatabaseManager<Object: Identifiable, Entity: CoreStoreObject>: DatabaseManagerProtocol {
    func set(object: Object, adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<Entity>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Entity in
            let builder = From<Entity>().where(format: equalIdsPredicateFormat, object.id)
            let entity = try transaction.fetchOne(builder) ?? transaction.create(Into<Entity>())
            return adapter(object, entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let entity): handler(.success(entity))
            }
        })
    }

    func set(objects: [Object], adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<[Entity]>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> [Entity] in
            return try objects.map { object in
                let builder = From<Entity>().where(format: equalIdsPredicateFormat, object.id)
                let entity = try transaction.fetchOne(builder) ?? transaction.create(Into<Entity>())
                return adapter(object, entity)
            }
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let entities): handler(.success(entities))
            }
        })
    }

    func set<Relationship: CoreStoreObject>(object: Object,
                                            relationship: [Relationship],
                                            adapter: @escaping (Object, Entity, [Relationship]) -> Entity,
                                            handler: @escaping Handler<Entity>) {

        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Entity in
            let builder = From<Entity>().where(format: equalIdsPredicateFormat, object.id)
            let entity = try transaction.fetchOne(builder) ?? transaction.create(Into<Entity>())
            let relationship = relationship.map { transaction.edit($0)! }
            return adapter(object, entity, relationship)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let entity): handler(.success(entity))
            }
        })
    }

    func getFirst(adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Object? in
            guard let entity = try transaction.fetchOne(From<Entity>()) else {
                return nil
            }

            return adapter(entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let object): handler(.success(object))
            }
        })
    }

    func getFirst(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Object? in
            let builder = From<Entity>().where(format: predicate, argumentArray: nil)
            guard let entity = try transaction.fetchOne(builder) else {
                return nil
            }

            return adapter(entity)
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let object): handler(.success(object))
            }
        })
    }

    func getAll(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<[Object]>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> [Object] in
            let builder = From<Entity>().where(format: predicate, argumentArray: nil)
            return try transaction.fetchAll(builder).map { adapter($0) }.reversed()
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let movies): handler(.success(movies))
            }
        })
    }

    func deleteAll(handler: @escaping Handler<Int>) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction in
            try transaction.deleteAll(From<Entity>())
        }, completionOnGlobal: { result in
            switch result {
            case .failure(let error): handler(.failure(error))
            case .success(let deletedEntitiesCount): handler(.success(deletedEntitiesCount))
            }
        })
    }
}
