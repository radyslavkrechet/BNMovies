//
//  UserAPIProtocol.swift
//  Data
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol UserAPIProtocol: class {
    func getUser(with token: String, handler: @escaping Handler<User>)
}
