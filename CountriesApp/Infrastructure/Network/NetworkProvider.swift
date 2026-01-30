//
//  NetworkProvider.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

final class NetworkProvider {
    static let shared = NetworkProvider()

    private let client: NetworkClient
    private let _context: CountriesContext

    var context: CountriesContext { _context }

    private init() {
        _context = CountriesContext(
            networkContext: NetworkContext(
                baseURLString: EnvironmentApp.apiUrl)
        )

        client = NetworkClient(
            context: _context,
            requestModifiers: [ // we can add modifier serve the network behave like language auth token & so on
                AuthorizationModifier()
            ]
        )
    }

    func makeClient() -> NetworkClient {
        return client
    }
}
