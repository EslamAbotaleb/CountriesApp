//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Eslam Abotaleb on 30/01/2026.
//

import Foundation

@MainActor
final class CountriesViewModel: BaseViewModel, ObservableObject {
    var isLoading: Bool = false
    var errorMessage: String?
}
