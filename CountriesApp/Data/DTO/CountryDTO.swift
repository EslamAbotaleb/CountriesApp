//
//  CountryDTO.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

struct CountryDTO: Identifiable, Hashable, Codable {
    var id = UUID()
    let name: String
    let capital: String
    let currency: String

    init(from response: CountryResponse) {
        self.name = response.name
        self.capital = response.capital ?? "-"
        self.currency = response.currencies?
            .map { currency in
                if let symbol = currency.symbol {
                    return "\(currency.name) (\(symbol))"
                }
                return currency.name
            }
            .joined(separator: ", ")
        ?? "-"
    }

    static func == (lhs: CountryDTO, rhs: CountryDTO) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension CountryDTO {
    init(name: String, capital: String, currency: String) {
        self.name = name
        self.capital = capital
        self.currency = currency
    }
}

// MARK: - Mock
extension CountryDTO {
    static func mock(
        id: UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        name: String = "Egypt",
        capital: String = "Cairo",
        currency: String = "EGP") -> CountryDTO {
        var country = CountryDTO(
            name: name,
            capital: capital,
            currency: currency
        )
        country.id = id
        return country
    }
}
