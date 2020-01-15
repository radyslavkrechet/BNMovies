//
//  UserRepositoryProtocol.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol UserRepositoryProtocol: class {
    func getUser(with token: String, handler: @escaping Handler<User>)
    func deleteUser(handler: @escaping Handler<Void>)
}
