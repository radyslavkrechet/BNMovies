//
//  SignInViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift
import RxCocoa

class SignInViewModel: ViewModelProtocol {
    let username = Variable<String>("")
    let password = Variable<String>("")

    private(set) lazy var loading: Observable<Void> = loadingSubject.observeOnMain()
    private(set) lazy var error: Observable<Error> = errorSubject.observeOnMain()
    private(set) lazy var userDidSignIn: Observable<Void> = userDidSignInSubject.observeOnMain()

    private(set) lazy var signInDidTap: AnyObserver<Void> = AnyObserver { [weak self] event in
        if case .next = event {
            self?.signIn()
        }
    }

    private let loadingSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    private let userDidSignInSubject = PublishSubject<Void>()
    private let signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    private func signIn() {
        loadingSubject.onNext(())
        signInUseCase.parameters = SignInUseCase.Parameters(username: username.value, password: password.value)
        signInUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.errorSubject.onNext(error)
            case .success: self?.userDidSignInSubject.onNext(())
            }
        }
    }
}
