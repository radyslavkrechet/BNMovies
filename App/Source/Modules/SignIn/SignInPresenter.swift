//
//  SignInPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?

    var username = ""
    var password = ""

    private let signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    func signIn() {
        view?.populate(with: .loading)
        signInUseCase.parameters = SignInUseCase.Parameters(username: username, password: password)
        signInUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success: self?.view?.userDidSignIn()
            }
        }
    }
}
