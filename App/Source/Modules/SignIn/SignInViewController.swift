//
//  SignInViewController.swift
//  Boilerplate
//
//  Created by Radyslav Krechet on 8/23/19.
//  Copyright © 2019 Radyslav Krechet. All rights reserved.
//

import UIKit

protocol SignInViewProtocol: ViewProtocol {
    func populate(with state: SignInState)
    func userDidSignIn()
}

class SignInViewController: ViewController<SignInPresenter>, SignInViewProtocol, UITextFieldDelegate {
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

    @objc private func keyboardWillHide(notification: Notification) {
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

    // MARK: - Actions

    @IBAction private func signInButtonDidTap(_ sender: UIButton) {
        presenter.signIn(with: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    // MARK: - SignInViewProtocol

    func populate(with state: SignInState) {
        switch state {
        case .loading:
            view.endEditing(true)
            activityIndicatorView.startAnimating()
            signInButton.isHidden = true
        case .error(let error):
            activityIndicatorView.stopAnimating()
            signInButton.isHidden = false
            presentErrorAlert(with: error.localizedDescription)
        }
    }

    func userDidSignIn() {
        analyticsService?.logSignIn()
        UIStoryboard.set(.Main)
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
