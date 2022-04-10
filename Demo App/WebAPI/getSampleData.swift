//
//  getSampleData.swift
//  Demo App
//
//  Created by Yu-Sung Loyi Hsu on 2022/4/10.
//

import Foundation

func getSampleData(filename: String) -> Data {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return Data()
    }
    return data
}
