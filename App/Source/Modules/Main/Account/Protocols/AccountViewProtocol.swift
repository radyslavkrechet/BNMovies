//
//  AccountViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol AccountViewProtocol: ContentViewProtocol {
    func populate(with user: User)
    func presentSignOutError(_ error: Error)
    func userDidSignOut()
}
