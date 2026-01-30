//
//  CountryResponse.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct CountryResponse: Decodable {
    let name: String
    let capital: String?
    let currencies: [Currency]?
    let independent: Bool?
    
    struct Currency: Decodable {
        let code: String?
        let name: String
        let symbol: String?
    }
}
