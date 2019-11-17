//
//  AuthenticationAPI.swift
//  Data
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol AuthAPIProtocol {
    func signIn(with username: String, password: String, handler: @escaping Handler<Session>)
}
