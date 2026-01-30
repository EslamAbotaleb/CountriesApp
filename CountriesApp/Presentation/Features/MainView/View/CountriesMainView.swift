//
//  CountriesMainView.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import SwiftUI

struct CountriesMainView: View {
    @StateObject private var viewModel = CountriesViewModel()
    
    private var selectedHeader: some View {
        HStack {
            Text("Selected Countries")
            Spacer()
            Text("\(viewModel.selectedCountries.count)/5")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private var emptyState: some View {
        ContentUnavailableView(
            "No Countries Selected",
            systemImage: "globe",
            description: Text("Search and add up to 5 countries")
        )
    }

    var body: some View {
        NavigationStack {
            List {
                // Selected Countries Section
                if !viewModel.selectedCountries.isEmpty {
                    Section {
                        ForEach(viewModel.selectedCountries) { country in
                            NavigationLink(value: country) {
                                SelectedCountryRow(country: country)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.removeCountry(country)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    } header: {
                        selectedHeader
                    }
                }

                // Search Results Section
                if !viewModel.searchResults.isEmpty {
                    Section("Search Results") {
                        ForEach(viewModel.searchResults) { country in
                            SearchResultRow(
                                country: country,
                                isDisabled: viewModel.selectedCountries.count >= 5
                            ) {
                                viewModel.addCountry(country)
                            }
                        }
                    }
                }

                // Empty State
                if viewModel.searchText.isEmpty &&
                    viewModel.selectedCountries.isEmpty {
                    emptyState
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Countries")
            .searchable(text: $viewModel.searchText, prompt: "Search by country")
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.search()
            }
            .navigationDestination(for: CountryDTO.self) { country in
                CountryDetailsView(country: country)
            }
            .task {
                await viewModel.loadCountries()
            }
        }
    }
}
