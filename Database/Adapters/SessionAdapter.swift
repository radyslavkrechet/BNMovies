//
//  SessionAdapter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/2/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

enum SessionAdapter {
    static func fromStorage(_ entity: SessionEntity) -> Session {
        return Session(token: entity.token.value)
    }

    static func toStorage(_ session: Session, _ entity: SessionEntity) {
        entity.token.value = session.token
    }
}
