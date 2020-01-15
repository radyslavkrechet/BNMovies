//
//  SessionAdapter.swift
//  Database
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SessionAdapterProtocol {
    func fromStorage(_ entity: SessionEntity) -> Session
    func toStorage(_ object: Session, _ entity: SessionEntity) -> SessionEntity
}

struct SessionAdapter: SessionAdapterProtocol {
    func fromStorage(_ entity: SessionEntity) -> Session {
        return Session(id: entity.id.value, token: entity.token.value)
    }

    func toStorage(_ object: Session, _ entity: SessionEntity) -> SessionEntity {
        entity.id.value = object.id
        entity.token.value = object.token
        return entity
    }
}
