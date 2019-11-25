//
//  SignInPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SignInPresenterProtocol: PresenterProtocol {
    func signIn(with username: String, password: String)
}

class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?

    private let signInUseCase: SignInUseCaseProtocol

    init(signInUseCase: SignInUseCaseProtocol) {
        self.signInUseCase = signInUseCase
    }

    func signIn(with username: String, password: String) {
        view?.populate(with: .loading)
        signInUseCase.set(username, password: password) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success: self?.view?.userDidSignIn()
            }
        }.execute()
    }
}
