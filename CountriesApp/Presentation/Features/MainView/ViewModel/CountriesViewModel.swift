//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Combine
import Foundation
import CoreLocation

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
    
    private let locationManager = LocationManager()
    private var searchTask: Task<Void, Never>?
    
    var locationCountryCode: String?

    // MARK: - Init
    init(getCountriesUseCase: GetCountriesUseCaseProtocol = GetCountriesUseCase(repository: CountriesRepository())) {
        self.getCountriesUseCase = getCountriesUseCase
        
        // Location callbacks
        locationManager.onCountryCode = { [weak self] code in
            guard let self = self else { return }
            self.locationCountryCode = code
            self.trySetDefaultCountry()
        }
        
        locationManager.onAuthorizationChanged = { [weak self] status in
            guard let self = self else { return }
            // set default country
            if status != .notDetermined {
                self.trySetDefaultCountry()
            }
        }
        
        locationManager.requestLocation()
    }
    
    // Load Countries
    func loadCountries() async {
        await MainActor.run { isLoading = true }

        await perform(action: {
            try await self.getCountriesUseCase.execute()
        }) { [weak self] countries in
            guard let self = self else { return }
            self.allCountries = countries
            self.setDefaultAfterCountriesLoaded()
        }

        await MainActor.run { isLoading = false }
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
}
