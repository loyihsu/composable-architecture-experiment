//
//  Demo_AppTests.swift
//  Demo AppTests
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import XCTest
import ComposableArchitecture
import Moya
@testable import Demo_App

class Demo_AppTests: XCTestCase {
    func testLoginSuccess() {
        let testStore = TestStore(
            initialState: LoginState(),
            reducer: loginReducer,
            environment: LoginEnvironment(
                mainQueue: .immediate,
                login: { _, _ in
                    let data = getSampleData(filename: "login_success")
                    return Effect<Response, MoyaError>(value: Response(statusCode: 200, data: data))
                }
            )
        )

        testStore.send(.loginButtonTapped(username: "abcdef", password: "123456")) {
            $0.isLoggingIn = true
        }

        testStore.receive(
            .loginResponse(result:
                .success(
                    Response(
                        statusCode: 200,
                        data: getSampleData(filename: "login_success")
                    )
                )
            )
        ) {
            $0.isLoggingIn = false
            $0.loginResult = .success(getSampleData(filename: "login_success"))
        }
    }
}
