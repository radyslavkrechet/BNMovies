//
//  SessionDAOProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain

public protocol SessionDAOProtocol {
    func set(_ session: Session, handler: @escaping Handler<Session>)
    func getSession(handler: @escaping Handler<Session?>)
    func deleteSession(handler: @escaping Handler<Void>)
}
