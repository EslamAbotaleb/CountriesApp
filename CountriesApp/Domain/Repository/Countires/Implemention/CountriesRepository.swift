//
//  CountriesRepository.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct CountriesRepository: CountriesRepositoryProtocol {
    func fetchCountries() async throws -> [CountryResponse] {
        let endPoint = CountryEndpoint.showCountries()
        return try await performRequest(endPoint)
    }
}
