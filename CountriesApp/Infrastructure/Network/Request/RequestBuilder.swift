//
//  RequestBuilder.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct RequestBuilder {
    static func makeRequest(from endpoint: Endpoint, baseURL: URL) -> URLRequest {
        // ✅ Build the full URL using context’s base URL
        let url = endpoint.url(with: baseURL)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // ✅ Common & custom headers
        endpoint.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
