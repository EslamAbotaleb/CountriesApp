//
//  CountryEndpoint.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct CountryEndpoint: Endpoint {
    var path: String
    var method: HTTPMethod
    var body: Data?
    var queryItems: [URLQueryItem]?
    
    init(path: String, method: HTTPMethod, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
    
    static func showCountries() -> CountryEndpoint {
        CountryEndpoint(
        path: "all", method: .GET,
        queryItems: [
            URLQueryItem(name: "fields", value: "name,capital,currencies")
        ])
    }
}
