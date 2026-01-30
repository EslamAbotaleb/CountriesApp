//
//  RequestModifier.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol RequestModifier {
    func modify(request: URLRequest, context: CountriesContext) async -> URLRequest
}

struct AuthorizationModifier: RequestModifier {
    func modify(request: URLRequest, context: CountriesContext) async -> URLRequest {
        return request
    }
}
