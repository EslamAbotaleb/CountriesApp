//
//  MockNetworkService.swift
//  CountriesAppTests
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
@testable import CountriesApp

final class MockNetworkService: NetworkServiceProtocol {

    var responseData: Data?
    var response: URLResponse?

    func sendRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        guard let data = responseData, let response = response else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
