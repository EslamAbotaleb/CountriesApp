//
//  CountriesRepositoryProtocol.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol CountriesRepositoryProtocol: BaseRepositoryProtocol {
    func fetchCountries() async throws -> [CountryResponse]
}
