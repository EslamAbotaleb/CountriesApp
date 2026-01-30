//
//  CountryDetailsView.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct CountryDetailsView: View {
    let country: CountryDTO

    var body: some View {
        VStack(spacing: 16) {
            Text(country.name).font(.largeTitle)
            Text("Capital: \(country.capital)")
            Text("Currency: \(country.currency)")
        }
        .padding()
    }
}
