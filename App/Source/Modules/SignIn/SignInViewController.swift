//
//  SignInViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import RxCocoa

class SignInViewController: ViewController<SignInViewModel>, UITextFieldDelegate {
    @IBOutlet private(set) weak var usernameTextField: UITextField!
    @IBOutlet private(set) weak var passwordTextField: UITextField!
    @IBOutlet private(set) weak var signInButton: UIButton!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private(set) weak var bottomLayoutConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNotifications()
    }

    override func setupViews() {
        super.setupViews()

        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        }
    }

    // MARK: - Setup

    override func setupBinding() {
        super.setupBinding()

        usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        signInButton.rx.tap
            .bind(to: viewModel.signInDidTap)
            .disposed(by: disposeBag)

        viewModel.loading.subscribe(onNext: { [weak self] _ in
            self?.processLoading()
        }).disposed(by: disposeBag)

        viewModel.error.subscribe(onNext: { [weak self] error in
            self?.process(error)
        }).disposed(by: disposeBag)

        viewModel.userDidSignIn.subscribe(onNext: { [weak self] _ in
            self?.userDidSignIn()
        }).disposed(by: disposeBag)
    }

    private func processLoading() {
        view.endEditing(true)
        activityIndicatorView.startAnimating()
        signInButton.isHidden = true
    }

    private func process(_ error: Error) {
        activityIndicatorView.stopAnimating()
        signInButton.isHidden = false
        presentErrorAlert(with: error.localizedDescription)
    }

    private func userDidSignIn() {
        analyticsManager?.logSignIn()

        UIStoryboard.set(.Main)
    }

    // MARK: - Notifications

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        updateBottomLayoutConstraint(with: notification)
    }

    @objc func keyboardWillHide(notification: Notification) {
        updateBottomLayoutConstraint(with: notification, keyboardWillHide: true)
    }

    private func updateBottomLayoutConstraint(with notification: Notification, keyboardWillHide: Bool = false) {
        guard let userInfo = notification.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {

                return
        }

        bottomLayoutConstraint.constant = keyboardWillHide ? 0 : frame.height

        let options = UIView.AnimationOptions(rawValue: curve)
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTextFieldTag = textField.tag + 1
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}
