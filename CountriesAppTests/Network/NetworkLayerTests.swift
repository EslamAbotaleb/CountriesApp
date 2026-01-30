//
//  NetworkLayerTests.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
import Testing
@testable import CountriesApp

@Suite
struct NetworkLayerTests {

    @Test
    func request_returnsDecodedResult() async throws {
        let network = MockNetworkService()
        let processor = MockResponseProcessor()

        processor.result = [
            CountryResponse(
                name: "France",
                capital: "Paris",
                currencies: [
                    CountryResponse.Currency(code: "EUR", name: "Euro", symbol: "€")
                ],
                independent: true
            )
        ]

        network.responseData = Data()
        network.response = HTTPURLResponse(
            url: URL(string: "https://restcountries.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Network client
        let client = NetworkClient(
            context: CountriesContext(
                networkContext: NetworkContext(baseURLString: "https://restcountries.com")
            ),
            network: network,
            requestModifiers: [],
            responseProcessor: processor
        )

        // Perform request
        let result: [CountryResponse] = try await client.request(CountryEndpoint.showCountries())

        // Assertions
        #expect(result.count == 1)
        #expect(result.first?.name == "France")
        #expect(result.first?.capital == "Paris")
    }
}
