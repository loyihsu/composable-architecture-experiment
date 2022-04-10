//
//  MoyaError + Equatable.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import Moya

extension MoyaError: Equatable {
    public static func == (lhs: MoyaError, rhs: MoyaError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
