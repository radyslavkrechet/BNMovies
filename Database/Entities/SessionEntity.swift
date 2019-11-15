//
//  SessionEntity.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 9/3/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import CoreStore

class SessionEntity: CoreStoreObject {
    let token = Value.Required<String>("token", initial: "")
}
