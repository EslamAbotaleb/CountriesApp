//
//  MockGetCountriesUseCase.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation
@testable import CountriesApp

enum MockError: Error {
    case failed
}

final class MockGetCountriesUseCase: GetCountriesUseCaseProtocol {

    var result: Result<[CountryDTO], Error> = .success([])

    func execute() async throws -> [CountryDTO] {
        switch result {
        case .success(let countries):
            return countries
        case .failure(let error):
            throw error
        }
    }
}
