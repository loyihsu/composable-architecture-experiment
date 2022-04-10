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

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Login", for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
            $0.edges.equalToSuperview()
        }
    }

    @objc func loginButtonTapped() {
        self.viewStore.send(.loginButtonTapped(username: "abc", password: "123456"))
    }

    private func setupNextScreen() {
        print("Setting up next screen...")
    }
}

