//
//  SignInPresenterProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol SignInPresenterProtocol: PresenterProtocol {
    var username: String { get set }
    var password: String { get set }

    func signIn()
}
