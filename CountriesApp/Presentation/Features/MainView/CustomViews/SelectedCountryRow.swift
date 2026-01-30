//
//  SelectedCountryRow.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct SelectedCountryRow: View {
    let country: CountryDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(country.name)
                .font(.headline)

            Text("Capital: \(country.capital)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
