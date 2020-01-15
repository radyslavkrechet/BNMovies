//
//  DatabaseManagerMock.swift
//  DatabaseTests
//
//  Created by Radyslav Krechet on 04.12.2019.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain
import CoreStore

@testable import Database

class DatabaseManagerMock<Object: Identifiable, Entity: CoreStoreObject>: DatabaseManagerProtocol {
    struct Settings {
        var shouldReturnError = false
        var shouldReturnNil = false
        var entity: Entity!
        var object: Object!
    }

    struct Calls {
        var setObject = false
        var setObjects = false
        var setObjectWithRelationship = false
        var getFirst = false
        var getFirstWithPredicate = false
        var getAll = false
        var deleteAll = false
    }

    struct Arguments {
        var object: Object?
        var objects: [Object]?
        var predicate: String?
    }

    var settings = Settings()
    var calls = Calls()
    var arguments = Arguments()

    func set(object: Object, adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<Entity>) {
        calls.setObject = true
        arguments.object = object
        _ = adapter(settings.object, settings.entity)
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(settings.entity))
    }

    func set(objects: [Object], adapter: @escaping (Object, Entity) -> Entity, handler: @escaping Handler<[Entity]>) {
        calls.setObjects = true
        arguments.objects = objects
        _ = adapter(settings.object, settings.entity)
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }

    func set<Relationship: CoreStoreObject>(object: Object,
                                            relationship: [Relationship],
                                            adapter: @escaping (Object, Entity, [Relationship]) -> Entity,
                                            handler: @escaping Handler<Entity>) {

        calls.setObjectWithRelationship = true
        arguments.object = object
        _ = adapter(settings.object, settings.entity, [])
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(settings.entity))
    }

    func getFirst(adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>) {
        calls.getFirst = true
        if !settings.shouldReturnNil {
            _ = adapter(settings.entity)
        }

        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnNil ? nil : settings.object))
    }

    func getFirst(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<Object?>) {
        calls.getFirstWithPredicate = true
        arguments.predicate = predicate
        if !settings.shouldReturnNil {
            _ = adapter(settings.entity)
        }

        handler(settings.shouldReturnError
            ? .failure(Mock.Error.force)
            : .success(settings.shouldReturnNil ? nil : settings.object))
    }

    func getAll(predicate: String, adapter: @escaping (Entity) -> Object, handler: @escaping Handler<[Object]>) {
        calls.getAll = true
        arguments.predicate = predicate
        _ = adapter(settings.entity)
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success([]))
    }

    func deleteAll(handler: @escaping Handler<Int>) {
        calls.deleteAll = true
        handler(settings.shouldReturnError ? .failure(Mock.Error.force) : .success(0))
    }
}
