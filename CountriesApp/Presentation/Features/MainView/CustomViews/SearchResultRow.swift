//
//  SearchResultRow.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct SearchResultRow: View {
    let country: CountryDTO
    let isDisabled: Bool
    let onAdd: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(country.name)
                    .font(.body)
                Text(country.capital)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: onAdd) {
                Image(systemName: "plus.circle.fill")
                    .font(.title3)
            }
            .disabled(isDisabled)
            .foregroundStyle(isDisabled ? .gray : .blue)
        }
        .padding(.vertical, 4)
    }
}
