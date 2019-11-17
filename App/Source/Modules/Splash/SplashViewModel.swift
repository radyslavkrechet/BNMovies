//
//  SplashViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import Domain
import RxSwift

class SplashViewModel: ContentViewModelProtocol {
    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var isSignedIn: Observable<Bool> = isSignedInSubject.observeOnMain()

    private let stateSubject = PublishSubject<ContentState>()
    private let isSignedInSubject = PublishSubject<Bool>()
    private let checkSessionUseCase: CheckSessionUseCase

    init(checkSessionUseCase: CheckSessionUseCase) {
        self.checkSessionUseCase = checkSessionUseCase
    }

    func getContent() {
        checkSession()
    }

    func tryAgain() {
        checkSession()
    }

    private func checkSession() {
        checkSessionUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
            case .success(let isSignedIn): self?.isSignedInSubject.onNext(isSignedIn)
            }
        }
    }
}
