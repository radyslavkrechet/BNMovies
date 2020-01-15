//
//  UserEntity.swift
//  Database
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import CoreStore

class UserEntity: CoreStoreObject {
    let id = Value.Required<String>("id", initial: "")
    let username = Value.Required<String>("username", initial: "")
    let name = Value.Optional<String>("name")
    let avatarSource = Value.Required<String>("avatarSource", initial: "")
}
