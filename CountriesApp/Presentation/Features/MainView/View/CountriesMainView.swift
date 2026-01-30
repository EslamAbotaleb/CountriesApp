//
//  CountriesMainView.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct CountriesMainView: View {
    @StateObject private var viewModel = CountriesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search
                TextField("Search by country", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: viewModel.searchText) { oldValue, newValue in
                        debugPrint("Value search text:\(newValue)")
                        viewModel.search()
                    }
                
                // Search Results
                if !viewModel.searchResults.isEmpty {
                    List(viewModel.searchResults) { country in
                        HStack {
                            Text(country.name)
                            Spacer()
                            Button("Add") {
                                viewModel.addCountry(country)
                            }
                            .disabled(viewModel.selectedCountries.count >= 5)
                        }
                    }
                }
                
                // Selected Countries
                List(viewModel.selectedCountries) { country in
                    NavigationLink(value: country) {
                        VStack(alignment: .leading) {
                            Text(country.name).font(.headline)
                            Text("Capital: \(country.capital)")
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.removeCountry(country)
                        } label: {
                            Label("Remove", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Countries")
            .task {
                await viewModel.loadCountries()
            }
        }
    }
}

#Preview {
    CountriesMainView()
}
