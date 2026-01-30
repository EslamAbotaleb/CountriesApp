//
//  MockInterceptor.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
@testable import CountriesApp

final class MockInterceptor: InterceptorChainProtocol {

    var wasCalled = false

    func modify(request: URLRequest) async -> URLRequest {
        wasCalled = true
        return request
    }
}
