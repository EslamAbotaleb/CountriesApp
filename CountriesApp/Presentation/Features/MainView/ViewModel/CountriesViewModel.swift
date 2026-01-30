//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Combine

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
    
    // MARK: - Init
    init(getCountriesUseCase: GetCountriesUseCaseProtocol = GetCountriesUseCase(repository: CountriesRepository())) {
        self.getCountriesUseCase = getCountriesUseCase
    }
}
