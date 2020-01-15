//
//  SessionDAOProtocol.swift
//  Data
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
//

import Domain

public protocol SessionDAOProtocol: class {
    func set(_ session: Session, handler: @escaping Handler<Session>)
    func getSession(handler: @escaping Handler<Session?>)
    func deleteSession(handler: @escaping Handler<Void>)
}
