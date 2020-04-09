//
//  SignInPresenter.swift
//  Movies
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2020 Radyslav Krechet. All rights reserved.
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
        signInUseCase.execute(with: username, password: password) { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success: self?.view?.userDidSignIn()
            }
        }
    }
}
