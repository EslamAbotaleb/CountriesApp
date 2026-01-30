//
//  Endpoint.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }

    func url(with baseURL: URL) -> URL
}

extension Endpoint {
    var headers: [String: String] {
        let baseHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        return baseHeaders
    }
        
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }

    func url(with baseURL: URL) -> URL {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )!
        components.queryItems = queryItems
        return components.url!
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
