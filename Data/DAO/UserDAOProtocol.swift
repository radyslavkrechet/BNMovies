//
//  UserDAOProtocol.swift
//  Data
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol UserDAOProtocol {
    func set(_ user: User, handler: @escaping Handler<User>)
    func getUser(handler: @escaping Handler<User?>)
    func deleteUser(handler: @escaping Handler<Void>)
}
