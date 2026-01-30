//
//  BaseRepositoryProtocol.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

protocol BaseRepositoryProtocol {
    var client: NetworkProtocol { get }
    var context: CountriesContext { get }
}
