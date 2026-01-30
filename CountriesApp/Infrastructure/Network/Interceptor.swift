//
//  Interceptor.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol InterceptorChainProtocol {
    func modify(request: URLRequest) async -> URLRequest
}

struct InterceptorChain: InterceptorChainProtocol {
    private let modifiers: [RequestModifier]
    private let context: CountriesContext

    init(modifiers: [RequestModifier], context: CountriesContext) {
        self.modifiers = modifiers
        self.context = context
    }

    func modify(request: URLRequest) async -> URLRequest {
        var modifiedRequest = request
        for modifier in modifiers {
            modifiedRequest = await modifier.modify(request: modifiedRequest, context: context)
        }
        return modifiedRequest
    }
}
