//
//  GetCountriesUseCaseProtocol.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol GetCountriesUseCaseProtocol {
    func execute() async throws -> [CountryDTO]
}
