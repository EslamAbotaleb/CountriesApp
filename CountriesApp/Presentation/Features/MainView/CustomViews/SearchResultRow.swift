//
//  SearchResultRow.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct SearchResultRow: View {
    let country: CountryDTO
    let isSelected: Bool
    let isDisabled: Bool
    let onAction: () -> Void

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

            Button(action: onAction) {
                Image(systemName: isSelected ? "minus.circle.fill" : "plus.circle.fill")
                    .font(.title3)
                    .foregroundStyle(isSelected ? .red : (isDisabled ? .gray : .blue))
            }
            .disabled(isDisabled && !isSelected)
        }
        .padding(.vertical, 4)
    }
}
