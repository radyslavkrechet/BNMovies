//
//  AccountPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

class AccountPresenter: AccountPresenterProtocol {
    weak var view: AccountViewProtocol?

    private let getUserUseCase: GetUserUseCase
    private let signOutUseCase: SignOutUseCase

    init(getUserUseCase: GetUserUseCase, signOutUseCase: SignOutUseCase) {
        self.getUserUseCase = getUserUseCase
        self.signOutUseCase = signOutUseCase
    }

    func getContent() {
        getUser()
    }

    func tryAgain() {
        getUser()
    }

    func signOut() {
        signOutUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.presentSignOutError(error)
            case .success: self?.view?.userDidSignOut()
            }
        }
    }

    private func getUser() {
        view?.populate(with: .loading)
        getUserUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let user): self?.process(user)
            }
        }
    }

    private func process(_ user: User) {
        view?.populate(with: user)
        view?.populate(with: .content)
    }
}
