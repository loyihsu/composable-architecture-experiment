//
//  LoginViewController.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import UIKit
import SnapKit
import ComposableArchitecture
import Combine

class LoginViewController: UIViewController {
    private let viewStore: ViewStore<LoginState, LoginAction>
    private var cancellable: Cancellable?

    private lazy var usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Username"
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }()

    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        return textfield
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Login", for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        return stackView
    }()

    init(store: Store<LoginState, LoginAction>) {
        viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBinding()
        setupUI()
    }

    private func setupBinding() {
        cancellable = viewStore.publisher.sink { [weak self] newLoginState in
            switch newLoginState.loginResult {
            case .success:
                self?.setupNextScreen()
            case .failure(let error):
                print(error)
            case .none:
                break
            }
        }

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchDown)
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
                .inset(15)
            $0.center.equalToSuperview()
        }
    }

    @objc func loginButtonTapped() {
        self.viewStore.send(
            .loginButtonTapped(
                username: usernameTextField.text ?? "",
                password: passwordTextField.text ?? ""
            )
        )
    }

    private func setupNextScreen() {
        print("Setting up next screen...")
    }
}

