//
//  MockResponseProcessor.swift
//  CountriesAppTests
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
@testable import CountriesApp

final class MockResponseProcessor: ResponseProcessorProtocol {
    var result: Any?

    func process<T>(response: URLResponse?, data: Data?) async throws -> T where T : Decodable {
        return result as! T
    }
}
