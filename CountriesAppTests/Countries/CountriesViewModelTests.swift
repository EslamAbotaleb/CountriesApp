//
//  CountriesViewModelTests.swift
//  CountriesAppTests
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Testing
@testable import CountriesApp

@MainActor
@Suite
struct CountriesViewModelTests {

    var viewModel: CountriesViewModel
    var mockUseCase: MockGetCountriesUseCase

    init() {
        mockUseCase = MockGetCountriesUseCase()
        viewModel = CountriesViewModel(getCountriesUseCase: mockUseCase)
    }

    @Test
    func testInitialState() {
        #expect(viewModel.allCountries.isEmpty)
        #expect(viewModel.selectedCountries.isEmpty)
        #expect(viewModel.searchText.isEmpty)
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testLoadCountriesSuccess() async {
        let countries = [
            CountryDTO.mock(name: "Egypt"),
            CountryDTO.mock(name: "France")
        ]
        mockUseCase.result = .success(countries)

        await viewModel.loadCountries()

        #expect(viewModel.allCountries.count == 2)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.isLoading == false)
    }

    @Test
    func testLoadCountriesFailure() async {
        mockUseCase.result = .failure(MockError.failed)

        await viewModel.loadCountries()

        #expect(viewModel.allCountries.isEmpty)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.isLoading == false)
    }

    @Test
    func testAddCountryDoesNotExceedLimit() {
        viewModel.selectedCountries = (1...5).map {
            CountryDTO.mock(name: "Country\($0)")
        }

        viewModel.addCountry(CountryDTO.mock(name: "Extra"))

        #expect(viewModel.selectedCountries.count == 5)
    }

    @Test
    func testRemoveCountryRemovesCorrectly() {
        let egypt = CountryDTO.mock(name: "Egypt")
        viewModel.selectedCountries = [egypt]

        viewModel.removeCountry(egypt)

        #expect(viewModel.selectedCountries.isEmpty)
    }
}
