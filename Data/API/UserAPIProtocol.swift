//
//  UserAPIProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

public protocol UserAPIProtocol {
    func getUser(with token: String, handler: @escaping Handler<User>)
}
