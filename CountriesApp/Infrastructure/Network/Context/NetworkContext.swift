//
//  NetworkContext.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

public struct NetworkContext {
    public var baseURLString: String
    public var path: String

    public init(
        baseURLString: String,
        path: String = "") {
        self.baseURLString = baseURLString
        self.path = path
    }

    public var baseURL: URL {
        guard let url = URL(string: baseURLString) else {
            preconditionFailure("Invalid URL string: \(baseURLString)")
        }
        return url
    }
}
