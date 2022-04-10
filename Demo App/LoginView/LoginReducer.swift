//
//  LoginReducer.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import ComposableArchitecture
import CombineMoya
import Moya

fileprivate let moyaProvider = MoyaProvider<MemberAPI>(
    stubClosure: MoyaProvider.immediatelyStub
)

struct LoginState: Equatable, Identifiable {
    let id = UUID()
    var isLoggingIn = false
    var loginResult: Result<Data, MoyaError>?
}

enum LoginAction: Equatable {
    case loginButtonTapped(username: String, password: String)
    case loginResponse(result: Result<Response, MoyaError>)
}

struct LoginEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>

    var login: (String, String) -> Effect<Response, MoyaError> = { username, password in
        return moyaProvider.requestPublisher(
            .login(
                username: username,
                password: password
            ),
            callbackQueue: .global(qos: .background)
        ).eraseToEffect()
    }
}

let loginReducer = Reducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
    switch action {
    case .loginButtonTapped(let username, let password):
        state.isLoggingIn = true
        return environment.login(username, password)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map { LoginAction.loginResponse(result: $0) }
    case let .loginResponse(.success(response)):
        state.isLoggingIn = false
        state.loginResult = .success(response.data)
        return .none
    case let .loginResponse(.failure(error)):
        state.isLoggingIn = false
        state.loginResult = .failure(error)
        return .none
    }
}
