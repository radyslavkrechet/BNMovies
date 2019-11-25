//
//  SplashPresenter.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain

protocol SplashPresenterProtocol: ContentPresenterProtocol {}

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?

    private let checkSessionUseCase: CheckSessionUseCaseProtocol

    init(checkSessionUseCase: CheckSessionUseCaseProtocol) {
        self.checkSessionUseCase = checkSessionUseCase
    }

    func getContent() {
        checkSession()
    }

    func tryAgain() {
        checkSession()
    }

    private func checkSession() {
        checkSessionUseCase.set { [weak self] result in
            switch result {
            case .failure(let error): self?.view?.populate(with: .error(error))
            case .success(let isSignedIn): self?.view?.navigate(isSignedIn)
            }
        }.execute()
    }
}
