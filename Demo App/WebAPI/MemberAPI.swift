//
//  MemberAPI.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import Moya
import Foundation

enum MemberAPI {
    case login(username: String, password: String)
}

extension MemberAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost")!
    }

    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }

    var sampleData: Data {
        switch self {
        case .login:
            return getSampleData(filename: "login_success")
        }
    }

    var task: Task {
        switch self {
        case .login(username: let username, password: let password):
            return .requestParameters(parameters: [
                "username": username,
                "password": password
            ], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
