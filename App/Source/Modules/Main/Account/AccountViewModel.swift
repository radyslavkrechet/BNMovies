//
//  AccountViewModel.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/28/19.
//  Copyright © 2019 RubyGarage. All rights reserved.
//

import Domain
import RxSwift

class AccountViewModel: ContentViewModelProtocol {
    private(set) lazy var state: Observable<ContentState> = stateSubject.observeOnMain()
    private(set) lazy var user: Observable<User> = userSubject.observeOnMain()
    private(set) lazy var userDidSignOut: Observable<Void> = userDidSignOutSubject.observeOnMain()
    private(set) lazy var signOutError: Observable<Error> = signOutErrorSubject.observeOnMain()

    private(set) lazy var signOutDidTap: AnyObserver<Void> = AnyObserver { [weak self] event in
        if case .next = event {
            self?.signOut()
        }
    }

    private let stateSubject = PublishSubject<ContentState>()
    private let userSubject = PublishSubject<User>()
    private let userDidSignOutSubject = PublishSubject<Void>()
    private let signOutErrorSubject = PublishSubject<Error>()
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

    private func getUser() {
        stateSubject.onNext(.loading)
        getUserUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.stateSubject.onNext(.error(error))
            case .success(let user): self?.process(user)
            }
        }
    }

    private func process(_ user: User) {
        userSubject.onNext(user)
        stateSubject.onNext(.content)
    }

    private func signOut() {
        signOutUseCase.execute { [weak self] result in
            switch result {
            case .failure(let error): self?.signOutErrorSubject.onNext(error)
            case .success: self?.userDidSignOutSubject.onNext(())
            }
        }
    }
}
