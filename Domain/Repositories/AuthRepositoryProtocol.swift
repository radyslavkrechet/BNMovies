//
//  AuthRepositoryProtocol.swift
//  Domain
//
//  Created by Radyslav Krechet on 8/22/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

public protocol AuthRepositoryProtocol: class {
    func signIn(with username: String, password: String, handler: @escaping Handler<Session>)
    func getSession(handler: @escaping Handler<Session?>)
    func isSignedIn(handler: @escaping Handler<Bool>)
    func signOut(handler: @escaping Handler<Void>)
}
