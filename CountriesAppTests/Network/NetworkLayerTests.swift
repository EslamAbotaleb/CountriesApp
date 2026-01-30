//
//  NetworkLayerTests.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
import Testing
@testable import CountriesApp

struct NetworkLayerTests {

    @Test
    func request_returnsDecodedResult() async throws {
        let network = MockNetworkService()
        let processor = MockResponseProcessor()
        let interceptor = MockInterceptor()

        processor.result = "Success"

        network.responseData = Data()
        network.response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let client = NetworkClient(
            context: CountriesContext(
                networkContext: NetworkContext(baseURLString: "https://test.com")
            ),
            network: network,
            interceptor: interceptor,
            responseProcessor: processor
        )

        let result: String = try await client.request(MockEndpoint())

        #expect(result == "Success")
    }
}
