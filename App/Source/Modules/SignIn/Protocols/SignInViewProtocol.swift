//
//  SignInViewProtocol.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 18.11.2019.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Foundation

protocol SignInViewProtocol: ViewProtocol {
    func populate(with state: SignInState)
    func userDidSignIn()
}
