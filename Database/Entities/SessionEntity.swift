//
//  SessionEntity.swift
//  Database
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import CoreStore

class SessionEntity: CoreStoreObject {
    let id = Value.Required<String>("id", initial: "")
    let token = Value.Required<String>("token", initial: "")
}
