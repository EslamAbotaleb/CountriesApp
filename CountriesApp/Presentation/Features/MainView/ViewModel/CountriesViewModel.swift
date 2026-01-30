//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Combine
import Foundation

final class CountriesViewModel: BaseViewModel {
    
    // MARK: - Properties BaseViewModel
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Published
    @Published var allCountries: [CountryDTO] = []
    @Published var selectedCountries: [CountryDTO] = []
    @Published var searchText: String = ""
    @Published var searchResults: [CountryDTO] = []
    
    // MARK: - Dependencies
    private let getCountriesUseCase: GetCountriesUseCaseProtocol
    
    private var searchTask: Task<Void, Never>?

    // MARK: - Init
    init(getCountriesUseCase: GetCountriesUseCaseProtocol = GetCountriesUseCase(repository: CountriesRepository())) {
        self.getCountriesUseCase = getCountriesUseCase
    }
    
    // Load Countries
    func loadCountries() async {
        await perform(action: {
            try await self.getCountriesUseCase.execute()
        }) { [weak self] countries in
            guard let self = self else { return }
            self.allCountries = countries
        }
    }
    
    // Search
    func search() {
        searchTask?.cancel()

        let query = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            searchResults = []
            return
        }

        let countriesList = allCountries

        searchTask = Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }

            let result = countriesList.filter {
                $0.name.lowercased().contains(query)
            }

            await MainActor.run {
                self.searchResults = result
            }
        }
    }
    
    // Add / Remove Countries
    func addCountry(_ country: CountryDTO) {
        guard selectedCountries.count < 5 else { return }
        guard !selectedCountries.contains(where: { $0.name == country.name }) else { return }
        selectedCountries.append(country)
    }
    
    func removeCountry(_ country: CountryDTO) {
        selectedCountries.removeAll { $0.id == country.id }
    }
}
