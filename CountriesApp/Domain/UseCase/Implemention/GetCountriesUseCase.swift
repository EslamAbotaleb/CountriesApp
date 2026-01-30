//
//  GetCountriesUseCase.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

final class GetCountriesUseCase: GetCountriesUseCaseProtocol {
    private let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CountryDTO] {
        let full = try await repository.fetchCountries()
        return full.map { CountryDTO(from: $0) } // map to DTO
    }
}
