//
//  File.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

extension BaseRepositoryProtocol {
    var client: NetworkProtocol {
        NetworkClient(context: NetworkProvider.shared.context)
    }
    var context: CountriesContext {
        NetworkProvider.shared.context
    }

    func performRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        try await client.request(endpoint)
    }
}
